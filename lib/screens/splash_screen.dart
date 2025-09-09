import 'package:flutter/material.dart';
import 'package:aetheria/screens/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback? onComplete;

  const SplashScreen({super.key, this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller, 
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut)
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    await _controller.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    
    if (mounted) {
      if (widget.onComplete != null) {
        widget.onComplete!();
      } else {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const DashboardScreen(),
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Simple icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D3748),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.auto_stories_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // App name
                  const Text(
                    'Aetheria',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF2D3748),
                      letterSpacing: -0.5,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Tagline
                  Text(
                    'Sermons for the soul',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Simple loading indicator
                  SizedBox(
                    width: 120,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF2D3748),
                      ),
                      minHeight: 2,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}