import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/botones.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: const [
              OnboardingPage(
                image: 'assets/Rectangle 1.png',
                title: 'Agenda tu hora medica',
                description:
                    'Ahora puedes programar tus citas\nmédicas de forma digital con solo unos\ncuantos clics.',
              ),
              OnboardingPage(
                image: 'assets/Rectangle 3.png',
                title: 'Una forma segura y rapida',
                description:
                    'Ahora puedes programar tus citas\nmédicas de forma digital con solo unos\ncuantos clics.',
              ),
              OnboardingPage(
                image: 'assets/Rectangle 2.png',
                title: 'Agenda tu hora medica',
                description:
                    'Ahora puedes programar tus citas\nmédicas de forma digital con solo unos\ncuantos clics.',
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage != 0)
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFF274CCE)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xFF274CCE)),
                    ),
                  ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CircleAvatar(
                          radius: 5.0,
                          backgroundColor: _currentPage == index
                              ? const Color(0xFF274CCE)
                              : const Color(0xFFB4D4FF),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF274CCE)),
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (_currentPage < 2) {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Botones()),
                        );
                      }
                    },
                    icon: const Icon(Icons.arrow_forward,
                        color: Color(0xFF274CCE)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        Image.asset(
          image,
          height: 350,
          width: 350,
        ),
        const SizedBox(height: 20.0),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF2F5FE1),
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20.0),
        Container(
          alignment: Alignment.center,
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
