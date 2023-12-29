import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ShareButton extends StatelessWidget {
  final String text;

  const ShareButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _shareText(context, text);
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFF1290FF),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: const Text(
        '공유하기',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Future<void> _shareText(BuildContext context, String text) async {
    if (kIsWeb) {
      await Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('텍스트가 클립보드에 복사되었습니다.')),
      );
    } else {
      Share.share(text);
    }
  }
}
