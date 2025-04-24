import 'package:flutter/material.dart';

void showCustomSnackBar(
  BuildContext context,
  String mensagem, {
  String tipo = 'info',
  int duracao = 2,
}) {
  Color bgColor;
  IconData icon;

  switch (tipo) {
    case 'sucesso':
      bgColor = Colors.green;
      icon = Icons.check_circle;
      break;
    case 'erro':
      bgColor = Colors.red;
      icon = Icons.error;
      break;
    default:
      bgColor = const Color.fromARGB(255, 50, 136, 242);
      icon = Icons.info;
  }

  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      return _AnimatedSnackBarWidget(
        message: mensagem,
        backgroundColor: bgColor,
        icon: icon,
        duracao: duracao,
        onDismissed: () => overlayEntry.remove(),
      );
    },
  );

  overlay.insert(overlayEntry);
}

class _AnimatedSnackBarWidget extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onDismissed;
  final int duracao;

  const _AnimatedSnackBarWidget({
    required this.message,
    required this.backgroundColor,
    required this.icon,
    required this.onDismissed,
    required this.duracao,
  });

  @override
  State<_AnimatedSnackBarWidget> createState() =>
      _AnimatedSnackBarWidgetState();
}

class _AnimatedSnackBarWidgetState extends State<_AnimatedSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    Future.delayed(Duration(seconds: widget.duracao), () async {
      await _controller.reverse();
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      left: 24,
      right: 24,
      child: Material(
        color: Colors.transparent,
        child: FadeTransition(
          opacity: _opacity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
