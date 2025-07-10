// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../theme/app_colors.dart';
import 'package:mamoyee/screens/chatbox_screen.dart';
import 'package:mamoyee/screens/diet_screen.dart';

class HomeScreen extends StatelessWidget {
  final double pregnancyProgress = 0.65;
  final int currentWeek = 26;
  final int totalWeeks = 40;
  final String fetusUpdate = "Your baby is about the size of a zucchini. Their eyes are starting to open!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.purple.withOpacity(0.9), AppColors.pink.withOpacity(0.9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.purple, AppColors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&auto=format&fit=crop&w=150&q=80'),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Nila',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(Icons.home, 'Home', () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              }),
              _buildDrawerItem(Icons.person, 'Profile', () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              }),
              _buildDrawerItem(Icons.calendar_today, 'Appointments', () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/appointments');
              }),
              _buildDrawerItem(Icons.book, 'Diary', () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/diary');
              }),
              _buildDrawerItem(Icons.self_improvement, 'Meditation', () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/meditation');
              }),
              Divider(color: Colors.white54, thickness: 1, indent: 16, endIndent: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text('Settings', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
              ),
              _buildDrawerItem(Icons.settings, 'Settings', () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              }),
              _buildDrawerItem(Icons.notifications, 'Notifications', () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/notifications');
              }),
              _buildDrawerItem(Icons.help_outline, 'Help & Support', () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/help');
              }),
              Divider(color: Colors.white54, thickness: 1, indent: 16, endIndent: 16),
              _buildDrawerItem(Icons.logout, 'Logout', () {
                Navigator.pop(context);
                // Add logout logic here if needed
              }),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 80),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.purple, AppColors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          padding: const EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  Text(
                    "Mamoyee",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.notifications_none, color: Colors.white),
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Hello Nila",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(height: 5),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 48),
                child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Search articles, tips, etc.',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pregnancy Progress", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))
                    ],
                  ),
                  child: Row(
                    children: [
                      CircularPercentIndicator(
                        radius: 70.0,
                        lineWidth: 10.0,
                        percent: pregnancyProgress,
                        center: Text(
                          "${(pregnancyProgress * 100).toStringAsFixed(0)}%",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        progressColor: AppColors.purple,
                        backgroundColor: AppColors.pink.withOpacity(0.2),
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("You are $currentWeek weeks pregnant", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                            SizedBox(height: 6),
                            Text("${totalWeeks - currentWeek} weeks to go", style: TextStyle(color: AppColors.lightText)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: AppColors.purple),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 600 ? 4 : 3;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      shrinkWrap: true,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        _HomeButton(label: 'Today\'s Q&A', icon: Icons.question_answer, route: '/home'),
                        _HomeButton(label: 'My Mood', icon: Icons.emoji_emotions, route: '/home'),
                        _HomeButton(label: 'My Diet', icon: Icons.fastfood, route: '/diet'), // Updated route here
                        _HomeButton(label: 'Appointments', icon: Icons.event, route: '/appoinments'),
                        _HomeButton(label: 'Meditation', icon: Icons.self_improvement, route: '/meditation'),
                        _HomeButton(label: 'Diary', icon: Icons.book, route: '/diary'),
                      ],
                    );
                  },
                ),
                SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.purple.withOpacity(0.7), AppColors.pink.withOpacity(0.5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Week $currentWeek", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                            SizedBox(height: 8),
                            Text(fetusUpdate, style: TextStyle(fontSize: 14, color: Colors.white)),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/3468/3468335.png',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: AppColors.purple,
              child: Icon(Icons.chat_bubble_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatBoxScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      onTap: onTap,
      hoverColor: Colors.white24,
      contentPadding: EdgeInsets.symmetric(horizontal: 24),
    );
  }
}

class _HomeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String route;

  const _HomeButton({required this.label, required this.icon, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.pink.withOpacity(1), AppColors.purple.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            SizedBox(height: 6),
            Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.white))
          ],
        ),
      ),
    );
  }
}
