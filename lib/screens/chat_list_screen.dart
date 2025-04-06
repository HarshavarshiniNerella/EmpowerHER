import 'package:empowerher/screens/chat_screen.dart';
import 'package:flutter/material.dart';
// import 'package:empowerher/constants/colors.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allChats = [];
  List<Map<String, dynamic>> _filteredChats = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  void _loadChats() {
    // In a real app, this would come from a database or API
    _allChats = [
      {
        'name': 'Sarah Johnson',
        'role': 'Senior Software Engineer',
        'lastMessage': 'Looking forward to our session tomorrow!',
        'time': DateTime.now().subtract(Duration(minutes: 5)),
        'unread': 2,
        'isOnline': true,
        'isMentor': true,
      },
      {
        'name': 'Emily Chen',
        'role': 'Product Manager',
        'lastMessage': 'Thanks for sharing that resource. It was very helpful.',
        'time': DateTime.now().subtract(Duration(hours: 2)),
        'unread': 0,
        'isOnline': false,
        'isMentor': true,
      },
      {
        'name': 'Jessica Williams',
        'role': 'UX Designer',
        'lastMessage': 'Can we reschedule our meeting to Thursday?',
        'time': DateTime.now().subtract(Duration(days: 1)),
        'unread': 1,
        'isOnline': true,
        'isMentor': true,
      },
      {
        'name': 'Leila Patel',
        'role': 'Data Scientist',
        'lastMessage': 'I found a great conference we should attend!',
        'time': DateTime.now().subtract(Duration(days: 2)),
        'unread': 0,
        'isOnline': false,
        'isMentor': true,
      },
      {
        'name': 'Rebecca Taylor',
        'role': 'Peer Mentee',
        'lastMessage': 'How did your presentation go?',
        'time': DateTime.now().subtract(Duration(days: 3)),
        'unread': 0,
        'isOnline': false,
        'isMentor': false,
      },
      {
        'name': 'Nicole Anderson',
        'role': 'Marketing Director',
        'lastMessage': 'I can help you with your branding question.',
        'time': DateTime.now().subtract(Duration(days: 4)),
        'unread': 0,
        'isOnline': true,
        'isMentor': true,
      },
      {
        'name': 'Support Team',
        'role': 'EmpowerHer Support',
        'lastMessage': 'Is there anything else we can help you with?',
        'time': DateTime.now().subtract(Duration(days: 5)),
        'unread': 0,
        'isOnline': true,
        'isMentor': false,
      },
    ];
    
    _filteredChats = List.from(_allChats);
  }

  void _filterChats(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredChats = List.from(_allChats);
      } else {
        _filteredChats = _allChats
            .where((chat) =>
                chat['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
                chat['role'].toString().toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search conversations...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: _filterChats,
              )
            : Text('Messages'),
        backgroundColor: AppColors.burgundy,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _filterChats('');
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryTabs(),
          Expanded(
            child: _filteredChats.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No conversations found',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = _filteredChats[index];
                      return _buildChatItem(chat);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to new message screen
        },
        backgroundColor: AppColors.coral,
        child: Icon(Icons.edit),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      color: AppColors.burgundy,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildCategoryTab('All', true),
          SizedBox(width: 16),
          _buildCategoryTab('Mentors', false),
          SizedBox(width: 16),
          _buildCategoryTab('Peers', false),
          SizedBox(width: 16),
          _buildCategoryTab('Unread', false),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String title, bool isActive) {
    return InkWell(
      onTap: () {
        // Filter chats by category
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.burgundy : Colors.white,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(recipient: chat),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: chat['isMentor'] ? AppColors.burgundy.withOpacity(0.2) : AppColors.coral.withOpacity(0.2),
                  child: Text(
                    chat['name'].toString().split(' ').map((e) => e[0]).join(''),
                    style: TextStyle(
                      color: chat['isMentor'] ? AppColors.burgundy : AppColors.coral,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (chat['isOnline'])
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat['name'],
                        style: TextStyle(
                          fontWeight: chat['unread'] > 0 ? FontWeight.bold : FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _formatTime(chat['time']),
                        style: TextStyle(
                          fontSize: 12,
                          color: chat['unread'] > 0 ? AppColors.coral : Colors.grey[600],
                          fontWeight: chat['unread'] > 0 ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    chat['role'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat['lastMessage'],
                          style: TextStyle(
                            fontSize: 14,
                            color: chat['unread'] > 0 ? Colors.black87 : Colors.grey[600],
                            fontWeight: chat['unread'] > 0 ? FontWeight.bold : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (chat['unread'] > 0)
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.coral,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            chat['unread'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
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

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter Conversations',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.burgundy,
                ),
              ),
              SizedBox(height: 20),
              _buildFilterOption('All Conversations', true),
              _buildFilterOption('Mentors Only', false),
              _buildFilterOption('Peers Only', false),
              _buildFilterOption('Unread Messages', false),
              _buildFilterOption('Active Now', false),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Reset Filters'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Apply'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.burgundy,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String title, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.coral : Colors.grey[400]!,
                width: 2,
              ),
              color: isSelected ? AppColors.coral : Colors.transparent,
            ),
            child: isSelected
                ? Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.white,
                  )
                : null,
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? AppColors.burgundy : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}