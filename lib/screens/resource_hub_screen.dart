// import 'package:empowerher/widgets/custom_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:empowerher/constants/colors.dart';
// // import 'package:empowerher/widgets/custom_app_bar.dart';
// class ResourceHubScreen extends StatefulWidget {
//   @override
//   *_ResourceHubScreenState createState() => *ResourceHubScreenState();
// }
// class _ResourceHubScreenState extends State<ResourceHubScreen> with SingleTickerProviderStateMixin {
//   final TextEditingController _searchController = TextEditingController();
//   late TabController _tabController;
//   bool _isSearching = false;
//   List<Map<String, dynamic>> _filteredResources = [];

//   final List<Map<String, dynamic>> _resources = [
//     {
//       'title': 'Navigating Tech as a Woman',
//       'description': 'A comprehensive guide to overcoming challenges and thriving in tech.',
//       'type': 'Guide',
//       'category': 'Career',
//       'author': 'Sarah Johnson',
//       'imageUrl': 'assets/images/tech_woman.jpg',
//       'rating': 4.8,
//       'isFavorite': false,
//     },
//     {
//       'title': 'Financial Independence for Women',
//       'description': 'Essential tips and strategies for building wealth and financial security.',
//       'type': 'E-Book',
//       'category': 'Finance',
//       'author': 'Maya Rodriguez',
//       'imageUrl': 'assets/images/finance.jpg',
//       'rating': 4.5,
//       'isFavorite': false,
//     },
//     {
//       'title': 'Women in Leadership',
//       'description': 'Insights and advice from successful female executives across various industries.',
//       'type': 'Podcast',
//       'category': 'Leadership',
//       'author': 'Emily Chen',
//       'imageUrl': 'assets/images/leadership.jpg',
//       'rating': 4.7,
//       'isFavorite': false,
//     },
//     {
//       'title': 'Self-Care Essentials',
//       'description': 'Practical self-care strategies for busy professional women.',
//       'type': 'Course',
//       'category': 'Wellness',
//       'author': 'Dr. Lisa Thompson',
//       'imageUrl': 'assets/images/selfcare.jpg',
//       'rating': 4.6,
//       'isFavorite': false,
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 5, vsync: this);
//     _filteredResources = _resources;
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     _filterResources(_searchController.text);
//   }

//   void _filterResources(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         _filteredResources = _resources;
//       } else {
//         _filteredResources = _resources
//             .where((resource) =>
//                 resource['title'].toLowerCase().contains(query.toLowerCase()) ||
//                 resource['description'].toLowerCase().contains(query.toLowerCase()) ||
//                 resource['author'].toLowerCase().contains(query.toLowerCase()))
//             .toList();
//       }
//     });
//   }

//   void _toggleSearch() {
//     setState(() {
//       _isSearching = !_isSearching;
//       if (!_isSearching) {
//         _searchController.clear();
//         _filteredResources = _resources;
//       }
//     });
//   }

//   void _toggleFavorite(int index) {
//     setState(() {
//       final resourceIndex = _resources.indexWhere(
//           (resource) => resource['title'] == _filteredResources[index]['title']);
//       if (resourceIndex != -1) {
//         _resources[resourceIndex]['isFavorite'] = !_resources[resourceIndex]['isFavorite'];
//         _filteredResources[index]['isFavorite'] = _resources[resourceIndex]['isFavorite'];
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: _isSearching
//             ? TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search resources...',
//                   border: InputBorder.none,
//                   hintStyle: TextStyle(color: Colors.white70),
//                 ),
//                 style: TextStyle(color: Colors.white),
//                 autofocus: true,
//               )
//             : Text('Resource Hub'),
//         actions: [
//           IconButton(
//             icon: Icon(_isSearching ? Icons.close : Icons.search),
//             onPressed: _toggleSearch,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           TabBar(
//             controller: _tabController,
//             isScrollable: true,
//             indicatorColor: AppColors.coral,
//             labelColor: AppColors.coral,
//             unselectedLabelColor: Colors.grey,
//             tabs: [
//               Tab(text: 'All'),
//               Tab(text: 'Career'),
//               Tab(text: 'Finance'),
//               Tab(text: 'Leadership'),
//               Tab(text: 'Wellness'),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildResourceList(_filteredResources),
//                 _buildResourceList(_filteredResources.where((r) => r['category'] == 'Career').toList()),
//                 _buildResourceList(_filteredResources.where((r) => r['category'] == 'Finance').toList()),
//                 _buildResourceList(_filteredResources.where((r) => r['category'] == 'Leadership').toList()),
//                 _buildResourceList(_filteredResources.where((r) => r['category'] == 'Wellness').toList()),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigate to resource submission screen
//           // Navigator.push(context, MaterialPageRoute(builder: (context) => AddResourceScreen()));
//         },
//         backgroundColor: AppColors.coral,
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildResourceList(List<Map<String, dynamic>> resources) {
//     return resources.isEmpty
//         ? Center(
//             child: Text(
//               'No resources found',
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//           )
//         : ListView.builder(
//             padding: EdgeInsets.all(16),
//             itemCount: resources.length,
//             itemBuilder: (context, index) {
//               final resource = resources[index];
//               return Card(
//                 elevation: 2,
//                 margin: EdgeInsets.only(bottom: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: InkWell(
//                   onTap: () {
//                     // Navigate to resource detail screen
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (context) => ResourceDetailScreen(resource: resource),
//                     //   ),
//                     // );
//                   },
//                   borderRadius: BorderRadius.circular(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                         child: Image.asset(
//                           resource['imageUrl'],
//                           height: 150,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: AppColors.coral.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Text(
//                                     resource['type'],
//                                     style: TextStyle(
//                                       color: AppColors.coral,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 8),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: AppColors.sand.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Text(
//                                     resource['category'],
//                                     style: TextStyle(
//                                       color: AppColors.sand,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Row(
//                                   children: [
//                                     Icon(Icons.star, color: Colors.amber, size: 16),
//                                     SizedBox(width: 4),
//                                     Text(
//                                       resource['rating'].toString(),
//                                       style: TextStyle(fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               resource['title'],
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               resource['description'],
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 14,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 12,
//                                   backgroundColor: AppColors.coral.withOpacity(0.2),
//                                   child: Text(
//                                     resource['author'][0],
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: AppColors.coral,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   'By ${resource['author']}',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 IconButton(
//                                   icon: Icon(
//                                     resource['isFavorite']
//                                         ? Icons.favorite
//                                         : Icons.favorite_border,
//                                     color: resource['isFavorite']
//                                         ? Colors.red
//                                         : Colors.grey,
//                                   ),
//                                   onPressed: () => _toggleFavorite(index),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//   }
// }

import 'package:empowerher/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:empowerher/constants/colors.dart'; // Ensure AppColors is being imported properly

class ResourceHubScreen extends StatefulWidget {
  @override
  _ResourceHubScreenState createState() => _ResourceHubScreenState();
}

class _ResourceHubScreenState extends State<ResourceHubScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  bool _isSearching = false;
  List<Map<String, dynamic>> _filteredResources = [];

  final List<Map<String, dynamic>> _resources = [
    {
      'title': 'Navigating Tech as a Woman',
      'description': 'A comprehensive guide to overcoming challenges and thriving in tech.',
      'type': 'Guide',
      'category': 'Career',
      'author': 'Sarah Johnson',
      'imageUrl': 'assets/tech_women.jpg',
      'rating': 4.8,
      'isFavorite': false,
    },
    {
      'title': 'Financial Independence for Women',
      'description': 'Essential tips and strategies for building wealth and financial security.',
      'type': 'E-Book',
      'category': 'Finance',
      'author': 'Maya Rodriguez',
      'imageUrl': 'assets/finance.jpg',
      'rating': 4.5,
      'isFavorite': false,
    },
    {
      'title': 'Women in Leadership',
      'description': 'Insights and advice from successful female executives across various industries.',
      'type': 'Podcast',
      'category': 'Leadership',
      'author': 'Emily Chen',
      'imageUrl': 'assets/tech_women.jpg',
      'rating': 4.7,
      'isFavorite': false,
    },
    {
      'title': 'Self-Care Essentials',
      'description': 'Practical self-care strategies for busy professional women.',
      'type': 'Course',
      'category': 'Wellness',
      'author': 'Dr. Lisa Thompson',
      'imageUrl': 'assets/finance.jpg',
      'rating': 4.6,
      'isFavorite': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _filteredResources = _resources;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterResources(_searchController.text);
  }

  void _filterResources(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredResources = _resources;
      } else {
        _filteredResources = _resources
            .where((resource) =>
                resource['title'].toLowerCase().contains(query.toLowerCase()) ||
                resource['description'].toLowerCase().contains(query.toLowerCase()) ||
                resource['author'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _filteredResources = _resources;
      }
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      final resourceIndex = _resources.indexWhere(
          (resource) => resource['title'] == _filteredResources[index]['title']);
      if (resourceIndex != -1) {
        _resources[resourceIndex]['isFavorite'] = !_resources[resourceIndex]['isFavorite'];
        _filteredResources[index]['isFavorite'] = _resources[resourceIndex]['isFavorite'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _isSearching
            ? 'Search Resources'  // Display a static title when searching
            : 'Resource Hub',     // Default title when not searching
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: AppColors.coral,  // Use the correct reference for AppColors
            labelColor: AppColors.coral,     // Apply AppColors correctly
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Career'),
              Tab(text: 'Finance'),
              Tab(text: 'Leadership'),
              Tab(text: 'Wellness'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildResourceList(_filteredResources),
                _buildResourceList(_filteredResources.where((r) => r['category'] == 'Career').toList()),
                _buildResourceList(_filteredResources.where((r) => r['category'] == 'Finance').toList()),
                _buildResourceList(_filteredResources.where((r) => r['category'] == 'Leadership').toList()),
                _buildResourceList(_filteredResources.where((r) => r['category'] == 'Wellness').toList()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to resource submission screen
          // Navigator.push(context, MaterialPageRoute(builder: (context) => AddResourceScreen()));
        },
        backgroundColor: AppColors.coral,  // Apply the AppColors correctly here
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildResourceList(List<Map<String, dynamic>> resources) {
    return resources.isEmpty
        ? Center(
            child: Text(
              'No resources found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: resources.length,
            itemBuilder: (context, index) {
              final resource = resources[index];
              return Card(
                elevation: 2,
                margin: EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    // Navigate to resource detail screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ResourceDetailScreen(resource: resource),
                    //   ),
                    // );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          resource['imageUrl'],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.coral.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    resource['type'],
                                    style: TextStyle(
                                      color: AppColors.coral,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.sand.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    resource['category'],
                                    style: TextStyle(
                                      color: AppColors.sand,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      resource['rating'].toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              resource['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              resource['description'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: AppColors.coral.withOpacity(0.2),
                                  child: Text(
                                    resource['author'][0],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.coral,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'By ${resource['author']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    resource['isFavorite']
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: resource['isFavorite']
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () => _toggleFavorite(index),
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
            },
          );
  }
}
