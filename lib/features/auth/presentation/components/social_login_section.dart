import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'O CONTINÚA CON',
                style: TextStyle(fontSize: 11, letterSpacing: 1, color: Colors.black45),
              ),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _SocialButton(
                icon: SvgPicture.asset('assets/icons/google.svg', width: 18),
                label: 'GOOGLE',
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SocialButton(
                icon: SvgPicture.asset('assets/icons/apple.svg', width: 18),
                label: 'APPLE',
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: icon,
      label: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.black26),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
