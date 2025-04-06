import 'package:empowerher/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:empowerher/widgets/custom_appbar.dart';
import 'package:empowerher/widgets/custom_button.dart';
// import 'package:empowerher/constants/colors.dart';


class MentorDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> mentor;

  const MentorDetailsScreen({required this.mentor});

  @override
  State<MentorDetailsScreen> createState() => _MentorDetailsScreenState();
}

class _MentorDetailsScreenState extends State<MentorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Mentor Profile",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMentorHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAboutSection(),
                  SizedBox(height: 24),
                  _buildExpertiseSection(),
                  SizedBox(height: 24),
                  _buildAvailabilitySection(),
                  SizedBox(height: 24),
                  _buildReviewsSection(),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "Request Mentorship",
                          onPressed: () {
                            // Show request dialog
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: "Message",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(recipient: widget.mentor),
                              ),
                            );
                          },
                          backgroundColor: AppColors.coral,
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
    );
  }

  Widget _buildMentorHeader() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.burgundy,
            AppColors.coral,
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
            ),
            child: Center(
              child: Text(
                widget.mentor['name'].toString().split(' ').map((e) => e[0]).join(''),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.burgundy,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            widget.mentor['name'],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            widget.mentor['role'],
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
              SizedBox(width: 4),
              Text(
                '${widget.mentor['rating']}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                ' (${widget.mentor['reviewCount']} reviews)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${widget.mentor['matchPercentage']}% Match',
              style: TextStyle(
                color: AppColors.burgundy,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.burgundy,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "I'm passionate about empowering women in tech through mentorship and guidance. "
          "With over 10 years of experience in the industry, I've helped numerous mentees "
          "navigate their career paths and achieve their goals. I believe in a personalized "
          "approach to mentorship that focuses on individual strengths and aspirations.",
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildExpertiseSection() {
    final expertise = [
      {'name': 'Leadership', 'level': 0.95},
      {'name': 'Technical Skills', 'level': 0.9},
      {'name': 'Career Development', 'level': 0.85},
      {'name': 'Work-Life Balance', 'level': 0.8},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expertise",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.burgundy,
          ),
        ),
        SizedBox(height: 16),
        ...expertise.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item['name'] as String),
                  Text('${((item['level'] as num).toDouble() * 100).toInt()}%'),
                ],
              ),
              SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: item['level'] as double,
                  minHeight: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.coral),
                ),
              ),
            ],
          ),
        )).toList(),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: (widget.mentor['specialties'] as List<String>).map((specialty) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                specialty,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAvailabilitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Availability",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.burgundy,
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sessions per week:",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text("${widget.mentor['sessionsPerWeek']}"),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Response time:",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text("${widget.mentor['responseTime']}"),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Next available:",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text("${widget.mentor['nextAvailable']}"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Reviews",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.burgundy,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all reviews
              },
              child: Text(
                "See all",
                style: TextStyle(color: AppColors.coral),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        if ((widget.mentor['reviews'] as List).isNotEmpty)
          ...(widget.mentor['reviews'] as List).take(2).map((review) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.coral.withOpacity(0.2),
                            child: Text(
                              review['author'][0],
                              style: TextStyle(
                                color: AppColors.coral,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review['author'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                review['date'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(
                                review['rating'].toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        review['content'],
                        style: TextStyle(height: 1.5),
                      ),
                    ],
                  ),
                ),
              )).toList()
        else
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text("No reviews yet"),
            ),
          ),
      ],
    );
  }
}
