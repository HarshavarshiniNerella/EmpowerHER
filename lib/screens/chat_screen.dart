import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> recipient;

  const ChatScreen({Key? key, required this.recipient}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialMessages() {
    // This would typically load messages from a database or API
    // For demo purposes, we'll add some sample messages
    final now = DateTime.now();
    
    _messages.addAll([
      {
        'text': 'Hello! I saw your profile and would love to discuss mentorship opportunities.',
        'isMe': true,
        'time': now.subtract(Duration(days: 2, hours: 3)),
        'status': 'read'
      },
      {
        'text': 'Hi there! I\'d be happy to discuss how I can help with your career goals. What specific areas are you looking to grow in?',
        'isMe': false,
        'time': now.subtract(Duration(days: 2, hours: 2)),
        'status': 'read'
      },
      {
        'text': 'I\'m primarily interested in improving my leadership skills and navigating promotion paths in tech companies.',
        'isMe': true,
        'time': now.subtract(Duration(days: 1, hours: 5)),
        'status': 'read'
      },
      {
        'text': 'Those are great areas to focus on! I have extensive experience with both. We could set up a weekly session to work on specific leadership challenges you\'re facing and create a roadmap for your career progression.',
        'isMe': false,
        'time': now.subtract(Duration(hours: 23)),
        'status': 'read'
      }
    ]);

    setState(() {});
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = {
      'text': _messageController.text,
      'isMe': true,
      'time': DateTime.now(),
      'status': 'sent'
    };

    setState(() {
      _messages.add(newMessage);
      _messageController.clear();
      _isTyping = true;
    });

    // Scroll to bottom after message is sent
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    // Simulate response from mentor
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add({
            'text': 'Thanks for your message! I\'ll get back to you soon.',
            'isMe': false,
            'time': DateTime.now(),
            'status': 'delivered'
          });
        });
        
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (now.difference(time).inDays > 0) {
      return DateFormat('MMM d, h:mm a').format(time);
    } else {
      return DateFormat('h:mm a').format(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.burgundy,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Text(
                widget.recipient['name'].toString().split(' ').map((e) => e[0]).join(''),
                style: TextStyle(
                  color: AppColors.burgundy,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipient['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.recipient['role'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam_outlined),
            onPressed: () {
              // Implement video call functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.call_outlined),
            onPressed: () {
              // Implement voice call functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages area
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
          ),
          
          // Typing indicator
          if (_isTyping)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              alignment: Alignment.centerLeft,
              color: Colors.white,
              child: Row(
                children: [
                  Text(
                    '${widget.recipient['name']} is typing...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          
          // Message input area
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, -1),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, color: AppColors.burgundy),
                  onPressed: () {
                    // Implement file attachment
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 1,
                    maxLines: 5,
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: _sendMessage,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.coral,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isMe = message['isMe'] as bool;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.burgundy,
              child: Text(
                widget.recipient['name'].toString().split(' ').map((e) => e[0]).join(''),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (!isMe) SizedBox(width: 8),
          
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.coral : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: isMe ? Radius.circular(20) : Radius.circular(0),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['text'] as String,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(message['time'] as DateTime),
                        style: TextStyle(
                          color: isMe ? Colors.white.withOpacity(0.8) : Colors.grey[600],
                          fontSize: 11,
                        ),
                      ),
                      if (isMe) ...[
                        SizedBox(width: 4),
                        Icon(
                          message['status'] == 'read' 
                              ? Icons.done_all 
                              : Icons.done,
                          size: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          if (isMe) SizedBox(width: 8),
          if (isMe)
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey[200],
              child: Text(
                'Me',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Assuming this class exists in your project
class AppColors {
  static const Color burgundy = Color(0xFF800020);
  static const Color coral = Color(0xFFFF6B6B);
}