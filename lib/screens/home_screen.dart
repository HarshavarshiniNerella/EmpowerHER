import 'package:empowerher/screens/mentor_matching_screen.dart';
import 'package:flutter/material.dart';
import 'package:empowerher/constants/colors.dart';
import 'package:empowerher/screens/mentor_matching_screen.dart';
import 'package:empowerher/screens/resource_hub_screen.dart';
import './event_calender_screen.dart';
import 'package:empowerher/screens/chat_list_screen.dart';
import 'package:empowerher/screens/achievements_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    HomeContent(),
    MentorshipMatchingScreen(),
    // ResourceHubScreen(),
    ChatListScreen(),
    // AchievementsScreen(),
  ];
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            selectedItemColor: AppColors.burgundy,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Mentors',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: 'Resources',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.emoji_events),
                label: 'Achievements',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'EmpowerHER',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.burgundy,
                      AppColors.coral,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Opacity(
                        opacity: 0.2,
                        child: Icon(
                          Icons.bubble_chart,
                          size: 150,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications, color: AppColors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.white,
                  child: Text(
                    'GI',
                    style: TextStyle(
                      color: AppColors.burgundy,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, Girl!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.burgundy,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Continue your journey of growth and empowerment',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildFeatureCards(context),
                  SizedBox(height: 24),
                  _buildUpcomingEvents(),
                  SizedBox(height: 24),
                  _buildLatestResources(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCards(BuildContext context) {
    final features = [
      {
        'title': 'Find a Mentor',
        'description': 'Connect with experienced professionals',
        'icon': Icons.person_search,
        'color': AppColors.coral,
        'route': MentorshipMatchingScreen(),
      },
      {
        'title': 'Browse Resources',
        'description': 'Tutorials, guides, and more',
        'icon': Icons.menu_book,
        'color': AppColors.burgundy,
        'route': ResourceHubScreen(),
      },
      {
        'title': 'Join Events',
        'description': 'Workshops and webinars',
        'icon': Icons.event,
        'color': AppColors.sand,
        'route': EventCalendarScreen(),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => feature['route'] as Widget),
            );
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: feature['color'] as Color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: (feature['color'] as Color).withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  feature['icon'] as IconData,
                  color: Colors.white,
                  size: 32,
                ),
                Spacer(),
                Text(
                  feature['title'] as String,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  feature['description'] as String,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUpcomingEvents() {
    final events = [
      {
        'title': 'Women in Tech Workshop',
        'date': 'Apr 10, 2:00 PM',
        'location': 'Virtual',
        'image': 'assets/images/event1.jpg',
      },
      {
        'title': 'Leadership Masterclass',
        'date': 'Apr 15, 5:30 PM',
        'location': 'City Conference Center',
        'image': 'assets/images/event2.jpg',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.burgundy,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to events screen
              },
              child: Text(
                'See All',
                style: TextStyle(
                  color: AppColors.coral,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Container(
                width: 260,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.sand.withOpacity(0.5),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.event,
                          size: 40,
                          color: AppColors.burgundy,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event['title'] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 12,
                                color: Colors.grey[600],
                              ),
                              SizedBox(width: 4),
                              Text(
                                event['date'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 12,
                                color: Colors.grey[600],
                              ),
                              SizedBox(width: 4),
                              Text(
                                event['location'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLatestResources() {
    final resources = [
      {
        'title': 'Getting Started in STEM',
        'category': 'Guide',
        'icon': Icons.science,
      },
      {
        'title': 'Building Confidence',
        'category': 'Tutorial',
        'icon': Icons.psychology,
      },
      {
        'title': 'Coding Fundamentals',
        'category': 'Course',
        'icon': Icons.code,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest Resources',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.burgundy,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to resources screen
              },
              child: Text(
                'See All',
                style: TextStyle(
                  color: AppColors.coral,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(
          children: resources.map((resource) {
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.sand.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      resource['icon'] as IconData,
                      color: AppColors.burgundy,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resource['title'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          resource['category'] as String,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.coral,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}