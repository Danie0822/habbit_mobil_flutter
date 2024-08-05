import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final int type;
  final void Function() onPressed;

  const CustomAlertDialog({
    required this.title,
    required this.message,
    required this.type,
    required this.onPressed,
    super.key,
  });

  IconData _getIcon() {
    switch (type) {
      case 1:
        return Icons.warning_amber_rounded;
      case 2:
        return Icons.error_outline_rounded;
      case 3:
        return Icons.check_circle_outline_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }

  Color _getColor() {
    switch (type) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.red;
      case 3:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getColor().withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(),
                color: _getColor(),
                size: 30,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _getColor(),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _getColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: onPressed,
              child: const Text(
                "Aceptar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showAlertDialog(String title, String message, int type, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: title,
        message: message,
        type: type,
        onPressed: () {
          context.pop();
        },
      );
    },
  );
}

void showAlertDialogScreen(String title, String message, int type, BuildContext context, String router) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: title,
        message: message,
        type: type,
        onPressed: () {
          context.push(router);
        },
      );
    },
  );
}
