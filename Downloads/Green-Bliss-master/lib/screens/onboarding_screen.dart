import 'package:Bliss/screens/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  static late List<Color> _backgroundColors;
  static late List<Color> _foregroundColors;
  static int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _backgroundColors = [Colors.white, Colors.black, const Color(0xFF478152)];
    _foregroundColors = [Colors.black, Colors.white, Colors.white];
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: _backgroundColors[_pageIndex],
      statusBarColor: _backgroundColors[_pageIndex],
    ));

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: _backgroundColors[_pageIndex],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: demo_data.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnBoardContent(
                    image: demo_data[index].image,
                    title: demo_data[index].title,
                    description: demo_data[index].description,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    demo_data.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor:
                            _OnBoardingScreenState._foregroundColors[
                                _OnBoardingScreenState._pageIndex],
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {
                        if (_pageIndex < demo_data.length - 1) {
                          _pageController.nextPage(
                            curve: Curves.ease,
                            duration: const Duration(milliseconds: 300),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const NavigationPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(0.0, 1.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        }
                      },
                      child: Icon(
                        Iconsax.arrow_right_1,
                        color: _OnBoardingScreenState._backgroundColors[
                            _OnBoardingScreenState._pageIndex],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: const Duration(microseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
          color: _OnBoardingScreenState
              ._foregroundColors[_OnBoardingScreenState._pageIndex],
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}

class Onboard {
  final String image, title, description;

  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

// ignore: non_constant_identifier_names
final List demo_data = [
  Onboard(
    image: 'assets/planet.png',
    title: '¡Explora Bliss y descubre el universo del reciclaje!',
    description:
        'Bliss: Explora un planeta verde con nuestra app para un estilo de vida sostenible. ¡Reciclemos juntos!',
  ),
  Onboard(
    image: 'assets/cats.jpg',
    title: 'Tu Mapa para un Mundo Más Verde',
    description:
        'Con Bliss, descubre puntos de reciclaje, tiendas eco y eventos verdes cercanos. Tu mundo sostenible a un toque de distancia.',
  ),
  Onboard(
    image: 'assets/ins.jpg',
    title: 'Inspírate y Aprende Sobre Reciclaje',
    description:
        'Explora historias, consejos y desafíos ecológicos en nuestro blog. ¡Inspírate y únete al cambio con Bliss!',
  ),
];

class OnBoardContent extends StatelessWidget {
  const OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Spacer(),
          Image.asset(
            image,
            height: 350,
          ),
          const Spacer(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              fontWeight: FontWeight.w900,
              color: _OnBoardingScreenState
                  ._foregroundColors[_OnBoardingScreenState._pageIndex],
            ),
          ),
          const Spacer(),
          Text(
            description,
            style: TextStyle(
              color: _OnBoardingScreenState
                  ._foregroundColors[_OnBoardingScreenState._pageIndex],
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer()
        ],
      ),
    );
  }
}
