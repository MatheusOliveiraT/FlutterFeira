import 'package:flutter/material.dart';

class BottomAppBarMonitor extends StatelessWidget {
  const BottomAppBarMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCircleIcon(
            icon: Icons.home,
            onPressed: () {
              Navigator.pushNamed(context, 'monitor');
            },
          ),
          const SizedBox(width: 32),
          _buildCircleIcon(
            icon: Icons.chat,
            onPressed: () {
              Navigator.pushNamed(context, '');
            },
          ),
          const SizedBox(width: 32),
          _buildCircleIcon(
            icon: Icons.account_circle,
            onPressed: () {
              Navigator.pushNamed(context, 'usuario/perfil/monitor');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        iconSize: 32,
        onPressed: onPressed,
      ),
    );
  }
}
