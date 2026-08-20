
import 'package:flutter/material.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/role_card.dart';

class _AnimatedRoleCardWrapper extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;
  const _AnimatedRoleCardWrapper({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_AnimatedRoleCardWrapper> createState() =>
      _AnimatedRoleCardWrapperState();
}
class _AnimatedRoleCardWrapperState extends State<_AnimatedRoleCardWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoleCard(
      title: widget.title,
      description: widget.description,
      icon: widget.icon,
      onTap: widget.onTap,
      fadeAnimation: _fadeAnimation,
      slideAnimation: _slideAnimation,
    );
  }
}