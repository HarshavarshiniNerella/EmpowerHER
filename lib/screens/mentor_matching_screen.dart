import 'package:empowerher/screens/mentor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:empowerher/constants/colors.dart';
import 'package:empowerher/widgets/custom_appbar.dart';
// import 'package:empowerher/screens/mentorship/mentor_details_screen.dart';

class MentorshipMatchingScreen extends StatefulWidget {
  @override
  _MentorshipMatchingScreenState createState() => _MentorshipMatchingScreenState();
}

class _MentorshipMatchingScreenState extends State<MentorshipMatchingScreen> {
  final _searchController = TextEditingController();
  List<String> _selectedCategories = [];
  
  final List<String> _categories = [
    'Technology', 'Business', 'Science', 'Arts', 'Leadership', 'Education'
  ];
  
  final List<Map<String, dynamic>> _mentors = [
    {
      'name': 'Dr. Sarah Johnson',
      'role': 'Tech Lead, Google',
      'rating': 4.9,
      'reviewCount': 124,
      'image': 'assets/images/mentor1.jpg',
      'specialties': ['AI/ML', 'Leadership', 'Career Growth'],
      'availability': 'Available',
      'matchPercentage': 95,
    },
    {
      'name': 'Maria Rodriguez',
      'role': 'UX Design Director',
      'rating': 4.7,
      'reviewCount': 89,
      'image': 'assets/images/mentor2.jpg',
      'specialties': ['UX/UI Design', 'Product Development'],
      'availability': 'Available in 2 days',
      'matchPercentage': 87,
    },
    {
      'name': 'Priya Sharma',
      'role': 'Senior Data Scientist',
      'rating': 4.8,
      'reviewCount': 105,
      'image': 'assets/images/mentor3.jpg',
      'specialties': ['Data Science', 'Statistics', 'Python'],
      'availability': 'Available',
      'matchPercentage': 82,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Find a Mentor",
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter dialog
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for mentors...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategories.contains(category);
                  
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedCategories.add(category);
                          } else {
                            _selectedCategories.remove(category);
                          }
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: AppColors.coral,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _mentors.length,
              itemBuilder: (context, index) {
                final mentor = _mentors[index];
                
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MentorDetailsScreen(mentor: mentor),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.sand,
                                ),
                                child: Center(
                                  child: Text(
                                    mentor['name'].toString().split(' ').map((e) => e[0]).join(''),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.burgundy,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mentor['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      mentor['role'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '${mentor['rating']} (${mentor['reviewCount']} reviews)',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: (mentor['specialties'] as List<String>).map((specialty) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.sand.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            specialty,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.burgundy,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.burgundy.withOpacity(0.1),
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                mentor['availability'],
                                style: TextStyle(
                                  color: mentor['availability'] == 'Available' 
                                      ? Colors.green 
                                      : Colors.orange,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.burgundy,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${mentor['matchPercentage']}% Match',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
