
enum UserType { Mentor, Mentee }

class User {
  final String id;
  final String name;
  final String email;
  final String profilePictureUrl;
  final UserType userType;
  final List<String> interests;
  final List<String> skills;
  final String careerGoal;
  final List<String> achievementBadges;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePictureUrl,
    required this.userType,
    required this.interests,
    required this.skills,
    required this.careerGoal,
    this.achievementBadges = const [],
  });
}

// models/event_model.dart

// Now let's create the custom widgets

// widgets/custom_button.dart
