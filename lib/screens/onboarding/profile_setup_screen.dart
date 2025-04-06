import 'package:empowerher/models/user_models.dart';
import 'package:flutter/material.dart';
import 'package:empowerher/constants/colors.dart';
import 'package:empowerher/widgets/custom_button.dart';
import 'package:empowerher/widgets/custom_appbar.dart';
import 'package:empowerher/screens/home_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  UserType _selectedUserType = UserType.Mentee;
  
  // Form controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  List<String> _selectedInterests = [];
  List<String> _selectedSkills = [];
  String _careerGoal = '';
  
  final List<String> _availableInterests = [
    'Technology', 'Science', 'Arts', 'Business', 
    'Leadership', 'Education', 'Healthcare', 'Engineering'
  ];
  
  final List<String> _availableSkills = [
    'Programming', 'Public Speaking', 'Writing', 'Design',
    'Research', 'Data Analysis', 'Marketing', 'Project Management'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Create Your Profile",
        showBackButton: false,
      ),
      body: SafeArea(
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() {
                _currentStep++;
              });
            } else {
              // Submit profile and navigate to home
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
              });
            }
          },
          steps: [
            Step(
              title: Text('Basic Info'),
              content: _buildBasicInfoStep(),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: Text('Role'),
              content: _buildRoleSelectionStep(),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: Text('Interests'),
              content: _buildInterestsStep(),
              isActive: _currentStep >= 2,
            ),
          ],
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: CustomButton(
                        text: 'Back',
                        onPressed: details.onStepCancel!,
                        backgroundColor: AppColors.grey,
                        textColor: AppColors.black,
                      ),
                    ),
                  if (_currentStep > 0)
                    SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: _currentStep == 2 ? 'Finish' : 'Next',
                      onPressed: details.onStepContinue!,
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

  Widget _buildBasicInfoStep() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.sand,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: AppColors.white,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.coral,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.camera_alt, color: AppColors.white),
                  onPressed: () {
                    // Add photo picking functionality
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person_outline, color: AppColors.coral),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email Address',
              prefixIcon: Icon(Icons.email_outlined, color: AppColors.coral),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline, color: AppColors.coral),
              suffixIcon: IconButton(
                icon: Icon(Icons.visibility),
                onPressed: () {},
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSelectionStep() {
    return Column(
      children: [
        Text(
          "I want to join as:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        _buildRoleCard(
          title: "Mentee",
          description: "Connect with mentors and learn from their experiences.",
          icon: Icons.school,
          isSelected: _selectedUserType == UserType.Mentee,
          onTap: () {
            setState(() {
              _selectedUserType = UserType.Mentee;
            });
          },
        ),
        SizedBox(height: 16),
        _buildRoleCard(
          title: "Mentor",
          description: "Share your knowledge and help others grow.",
          icon: Icons.supervisor_account,
          isSelected: _selectedUserType == UserType.Mentor,
          onTap: () {
            setState(() {
              _selectedUserType = UserType.Mentor;
            });
          },
        ),
      ],
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColors.burgundy : AppColors.grey,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? AppColors.burgundy.withOpacity(0.1) : Colors.white,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.burgundy : AppColors.sand,
              ),
              child: Icon(
                icon,
                color: AppColors.white,
                size: 28,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.burgundy : AppColors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.burgundy,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select your interests",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableInterests.map((interest) {
            final isSelected = _selectedInterests.contains(interest);
            return FilterChip(
              label: Text(interest),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedInterests.add(interest);
                  } else {
                    _selectedInterests.remove(interest);
                  }
                });
              },
              selectedColor: AppColors.coral.withOpacity(0.7),
              checkmarkColor: AppColors.white,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.white : AppColors.black,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        Text(
          "Select your skills",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableSkills.map((skill) {
            final isSelected = _selectedSkills.contains(skill);
            return FilterChip(
              label: Text(skill),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedSkills.add(skill);
                  } else {
                    _selectedSkills.remove(skill);
                  }
                });
              },
              selectedColor: AppColors.burgundy.withOpacity(0.7),
              checkmarkColor: AppColors.white,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.white : AppColors.black,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        Text(
          "Career goal",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        TextFormField(
          decoration: InputDecoration(
            hintText: "What is your career goal?",
            prefixIcon: Icon(Icons.flag, color: AppColors.coral),
          ),
          onChanged: (value) {
            _careerGoal = value;
          },
        ),
      ],
    );
  }
}