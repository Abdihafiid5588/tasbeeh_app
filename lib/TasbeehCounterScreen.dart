import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'counter_screen.dart';
import 'dhikr.dart';  // Ensure this import is present
import 'notification_service.dart';  // Ensure this import is present

class TasbeehCounterScreen extends StatefulWidget {
  @override
  _TasbeehCounterScreenState createState() => _TasbeehCounterScreenState();
}

class _TasbeehCounterScreenState extends State<TasbeehCounterScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToDhikrScreen(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => DhikrScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void _showNotification() {
    NotificationService().showNotification(
      0,
      'Reminder',
      'Time for Dhikr!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Minimalist background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 233, 224, 224), Color.fromARGB(255, 237, 229, 203)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/bg1.jpeg'), // Replace with your actual image path
                      radius: 40,
                    ),
                    SizedBox(height: 8),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Ifi Tasbeeh Counter',
                          textStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _showNotification,
                      child: Text('Show Notification'),
                    ),
                    SlideTransition(
                      position: _offsetAnimation,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: OpenContainer(
                          closedElevation: 0,
                          openElevation: 4,
                          transitionType: ContainerTransitionType.fade,
                          closedBuilder: (context, openContainer) {
                            return FeatureCard(
                              gradientColors: [Color(0xFF833ab4), Color(0xFFfd1d1d), Color(0xFFfcb045)],
                              icon: 'assets/images/Quran.png', // Replace with your actual icon path
                              title: 'Tasbeeh Counter',
                              subtitle: 'Go to >',
                              isMainCard: true,
                              onTap: openContainer,
                            );
                          },
                          openBuilder: (context, _) {
                            return CounterScreen();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    SlideTransition(
                      position: _offsetAnimation,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            FeatureCard(
                              gradientColors: [Color(0xFF007991), Color(0xFF78ffd6)],
                              icon: 'assets/images/Quran.png', // Replace with your actual icon path
                              title: 'Dhikr',
                              subtitle: 'Go to >',
                              onTap: () => _navigateToDhikrScreen(context),
                            ),
                            FeatureCard(
                              gradientColors: [Color(0xFF833ab4), Color(0xFFfd1d1d), Color(0xFFfcb045)],
                              icon: 'assets/images/star.png', // Replace with your actual icon path
                              title: 'Rate',
                              subtitle: 'Go to >',
                            ),
                            FeatureCard(
                              gradientColors: [Color(0xFFff9966), Color(0xFFff5e62)],
                              icon: 'assets/images/share.png', // Replace with your actual icon path
                              title: 'Share',
                              subtitle: 'Go to >',
                            ),
                            FeatureCard(
                              gradientColors: [Color(0xFF654ea3), Color(0xFFeaafc8)],
                              icon: 'assets/images/more.png', // Replace with your actual icon path
                              title: 'More',
                              subtitle: 'Go to >',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatefulWidget {
  final List<Color> gradientColors;
  final String icon;
  final String title;
  final String subtitle;
  final bool isMainCard;
  final VoidCallback? onTap;

  FeatureCard({
    required this.gradientColors,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isMainCard = false,
    this.onTap,
  });

  @override
  _FeatureCardState createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> with SingleTickerProviderStateMixin {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () {},
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
          height: widget.isMainCard ? 200 : 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: WavePainter(),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  widget.icon,
                  height: 36,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.65,
      size.width * 0.5,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.85,
      size.width,
      size.height * 0.75,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
