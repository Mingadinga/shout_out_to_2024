import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:shout_out_to_2024/color/colors.dart';
import 'package:flutter/services.dart';
import 'package:shout_out_to_2024/widget/push_preview_button.dart';
import 'package:shout_out_to_2024/widget/result_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shout_out_to_2024/widget/share_button.dart';
import 'package:shout_out_to_2024/widget/sns_share_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultShareScreen extends StatelessWidget {
  final String result;
  final String shareMent = '\n새해 목표 세우러 가기 : ';
  final String shareLink;

  ResultShareScreen({super.key, required this.result})
      : shareLink = dotenv.get('SOT2_URL');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            SizedBox(width: 300, child: ResultWidget(result)),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: Column(
                children: [
                  // ShareButton(
                  //   text: result + shareMent + shareLink,
                  // ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "2024 목표를 사람들과 공유해보세요!",
                      style: TextStyle(color: textColor, fontSize: 12),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CopyToClipboardIcon(text: result + shareMent + shareLink),
                      const SizedBox(width: 40),
                      // KakaoShare(result: result, shareLink: shareLink),
                      // FacebookShareIcon(
                      //     result: result + shareMent, shareLink: shareLink),
                      TwitterShareIcon(
                          result: result + shareMent, shareLink: shareLink),
                    ],
                  ),
                  const PushPreviewButtonWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TwitterShareIcon extends StatelessWidget {
  const TwitterShareIcon({
    super.key,
    required this.result,
    required this.shareLink,
  });

  final String result;
  final String shareLink;

  @override
  Widget build(BuildContext context) {
    return SnsShareIconWidget(
      icon: SvgPicture.asset(
        'assets/icons/twitter-alt.svg',
        width: 24,
        height: 24,
        color: iconColor,
      ),
      text: "트위터",
      onPressed: () async {
        var url = Uri(
          scheme: 'https',
          host: 'twitter.com',
          path: '/intent/tweet',
          queryParameters: {'text': result, 'url': shareLink},
        );
        await launchUrl(url);
      },
    );
  }
}

class FacebookShareIcon extends StatelessWidget {
  const FacebookShareIcon({
    super.key,
    required this.result,
    required this.shareLink,
  });

  final String result;
  final String shareLink;

  @override
  Widget build(BuildContext context) {
    return SnsShareIconWidget(
      icon: const Icon(Icons.facebook),
      text: "페이스북",
      onPressed: () async {
        var url = Uri(
          scheme: 'https',
          host: 'www.facebook.com',
          path: '/sharer/sharer.php',
          queryParameters: {
            'quote': Uri.encodeComponent(result),
            'u': shareLink
          },
        );
        await launchUrl(url);
      },
    );
  }
}

class KakaoShare extends StatelessWidget {
  const KakaoShare({
    super.key,
    required this.result,
    required this.shareLink,
  });

  final String result;
  final String shareLink;

  @override
  Widget build(BuildContext context) {
    return SnsShareIconWidget(
      icon: SvgPicture.asset(
        'assets/icons/comment.svg',
        width: 24,
        height: 24,
        color: iconColor,
      ),
      text: "카카오톡",
      onPressed: () async {
        final TextTemplate defaultText = TextTemplate(
          text: result,
          buttonTitle: '신년 목표 세우기',
          link: Link(
            webUrl: Uri.parse(shareLink),
            mobileWebUrl: Uri.parse(shareLink),
          ),
        );

        bool isKakaoTalkSharingAvailable =
            await ShareClient.instance.isKakaoTalkSharingAvailable();

        if (isKakaoTalkSharingAvailable) {
          try {
            Uri uri =
                await ShareClient.instance.shareDefault(template: defaultText);
            await ShareClient.instance.launchKakaoTalk(uri);
          } catch (error) {
            print(error);
          }
        } else {
          try {
            Uri shareUrl = await WebSharerClient.instance
                .makeDefaultUrl(template: defaultText);
            await launchBrowserTab(shareUrl, popupOpen: true);
          } catch (error) {
            print(error);
          }
        }
      },
    );
  }
}

class CopyToClipboardIcon extends StatelessWidget {
  const CopyToClipboardIcon({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SnsShareIconWidget(
      icon: const Icon(Icons.text_fields_rounded),
      text: "텍스트 복사",
      onPressed: () {
        Clipboard.setData(ClipboardData(text: text));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('텍스트가 클립보드에 복사되었습니다.')),
        );
      },
    );
  }
}
