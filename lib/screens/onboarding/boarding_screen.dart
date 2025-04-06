import 'package:flutter/material.dart';
import 'package:empowerher/constants/colors.dart';
import 'package:empowerher/widgets/custom_button.dart';
import 'package:empowerher/screens/onboarding/profile_setup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: "Find Your Perfect Mentor",
      description: "Connect with experienced mentors who can guide you through your journey.",
      image: "assets/mentorship.png",
      backgroundColor: AppColors.sand.withOpacity(0.2),
    ),
    OnboardingPage(
      title: "Access Valuable Resources",
      description: "Discover curated content to help you develop your skills and knowledge.",
      image: "assets/resources.png",
      backgroundColor: AppColors.coral.withOpacity(0.2),
    ),
    OnboardingPage(
      title: "Join Events & Workshops",
      description: "Participate in virtual and in-person events designed to help you grow.",
      image: "assets/events.png",
      backgroundColor: AppColors.burgundy.withOpacity(0.2),
    ),
    OnboardingPage(
      title: "Track Your Progress",
      description: "Earn badges and celebrate your achievements along the way.",
      image: "assets/track.png",
      backgroundColor: AppColors.sand.withOpacity(0.2),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(page: _pages[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => _buildDot(index),
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    text: _currentPage == _pages.length - 1 ? "Get Started" : "Next",
                    onPressed: () {
                      if (_currentPage == _pages.length - 1) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => ProfileSetupScreen()),
                        );
                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    icon: _currentPage == _pages.length - 1 ? Icons.rocket_launch : Icons.arrow_forward,
                  ),
                  if (_currentPage < _pages.length - 1) ...[
                    SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => ProfileSetupScreen()),
                        );
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: AppColors.coral,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: _currentPage == index ? 25 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.burgundy : AppColors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String image;
  final Color backgroundColor;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageWidget({required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: page.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            height: 250,
            child: Image.asset(page.image), // Replace with Image.asset(page.image) when you have assets
          ),
          SizedBox(height: 50),
          Text(
            page.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.burgundy,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            page.description,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}