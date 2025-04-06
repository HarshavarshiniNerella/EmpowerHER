import 'package:flutter/material.dart';
import 'package:empowerher/constants/colors.dart';
// import 'package:empowerher/widgets/custom_app_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AchievementsScreen extends StatefulWidget {
  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Your Achievements',
                  style: TextStyle(
                    color: AppColors.white,
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
                            Icons.emoji_events,
                            size: 150,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 80,
                        left: 20,
                        child: Row(
                          children: [
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 10.0,
                              percent: 0.72,
                              center: Text(
                                "72%",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              progressColor: Colors.white,
                              backgroundColor: Colors.white.withOpacity(0.3),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Level 5: Achiever',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '720/1000 XP to Level 6',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: 'BADGES'),
                  Tab(text: 'PROGRESS'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildBadgesTab(),
            _buildProgressTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgesTab() {
    final badges = [
      {
        'title': 'First Steps',
        'description': 'Completed your profile',
        'icon': Icons.person,
        'earned': true,
        'date': 'Mar 15, 2025'
      },
      {
        'title': 'Connector',
        'description': 'Connected with 5 mentors',
        'icon': Icons.people,
        'earned': true,
        'date': 'Mar 20, 2025'
      },
      {
        'title': 'Knowledge Seeker',
        'description': 'Completed 3 resource modules',
        'icon': Icons.menu_book,
        'earned': true,
        'date': 'Mar 28, 2025'
      },
      {
        'title': 'Event Enthusiast',
        'description': 'Attended 2 virtual events',
        'icon': Icons.event,
        'earned': false,
        'progress': 0.5,
      },
      {
        'title': 'Feedback Champion',
        'description': 'Provided feedback for 3 sessions',
        'icon': Icons.star,
        'earned': false,
        'progress': 0.33,
      },
      {
        'title': 'Networking Pro',
        'description': 'Exchanged contact with 10 peers',
        'icon': Icons.handshake,
        'earned': false,
        'progress': 0.2,
      },
      {
        'title': 'Active Learner',
        'description': 'Logged in for 7 consecutive days',
        'icon': Icons.calendar_today,
        'earned': false,
        'progress': 0.7,
      },
    ];

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'Earned Badges',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.burgundy,
          ),
        ),
        SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: badges.where((b) => b['earned'] == true).length,
          itemBuilder: (context, index) {
            final badge = badges.where((b) => b['earned'] == true).toList()[index];
            return _buildBadgeItem(badge, true);
          },
        ),
        SizedBox(height: 24),
        Text(
          'Badges in Progress',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.burgundy,
          ),
        ),
        SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: badges.where((b) => b['earned'] == false).length,
          itemBuilder: (context, index) {
            final badge = badges.where((b) => b['earned'] == false).toList()[index];
            return _buildBadgeItem(badge, false);
          },
        ),
      ],
    );
  }

  Widget _buildBadgeItem(Map<String, dynamic> badge, bool earned) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          earned
              ? Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.coral, AppColors.burgundy],
                    ),
                  ),
                  child: Icon(
                    badge['icon'] as IconData,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 4.0,
                      percent: badge['progress'] as double,
                      center: Icon(
                        badge['icon'] as IconData,
                        color: Colors.grey[400],
                        size: 24,
                      ),
                      progressColor: AppColors.coral,
                      backgroundColor: Colors.grey[200]!,
                    ),
                  ],
                ),
          SizedBox(height: 12),
          Text(
            badge['title'] as String,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              earned
                  ? (badge['date'] as String)
                  : '${(badge['progress'] as double) * 100.toInt()}%'
,

              style: TextStyle(
                fontSize: 10,
                color: earned ? AppColors.coral : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    final milestones = [
      {
        'title': 'Profile Completion',
        'progress': 0.9,
        'tasks': [
          {'name': 'Basic Info', 'completed': true},
          {'name': 'Professional Background', 'completed': true},
          {'name': 'Skills & Interests', 'completed': true},
          {'name': 'Upload Photo', 'completed': false},
        ]
      },
      {
        'title': 'Mentorship Journey',
        'progress': 0.5,
        'tasks': [
          {'name': 'Connect with a mentor', 'completed': true},
          {'name': 'Complete first session', 'completed': true},
          {'name': 'Set career goals', 'completed': false},
          {'name': 'Get session feedback', 'completed': false},
        ]
      },
      {
        'title': 'Learning Path',
        'progress': 0.33,
        'tasks': [
          {'name': 'Complete orientation', 'completed': true},
          {'name': 'Finish first module', 'completed': false},
          {'name': 'Take assessment', 'completed': false},
        ]
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: milestones.length,
      itemBuilder: (context, index) {
        final milestone = milestones[index];
        final tasks = milestone['tasks'] as List;
        final completedTasks = tasks.where((t) => t['completed'] == true).length;
        
        return Container(
          margin: EdgeInsets.only(bottom: 24),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    milestone['title'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.burgundy,
                    ),
                  ),
                  Text(
                    '$completedTasks/${tasks.length}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.coral,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              LinearPercentIndicator(
                lineHeight: 8.0,
                percent: milestone['progress'] as double,
                backgroundColor: Colors.grey[200],
                progressColor: AppColors.coral,
                barRadius: Radius.circular(4),
                padding: EdgeInsets.zero,
              ),
              SizedBox(height: 16),
              ...tasks.map((task) {
                final completed = task['completed'] as bool;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: completed ? AppColors.coral : Colors.grey[300],
                        ),
                        child: Icon(
                          completed ? Icons.check : Icons.hourglass_empty,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        task['name'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          color: completed ? Colors.black87 : Colors.grey[600],
                          decoration: completed ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: 12),
              if (milestone['progress'] as double < 1.0)
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navigate to relevant section to complete milestone
                    },
                    child: Text(
                      'Continue Progress',
                      style: TextStyle(
                        color: AppColors.burgundy,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}