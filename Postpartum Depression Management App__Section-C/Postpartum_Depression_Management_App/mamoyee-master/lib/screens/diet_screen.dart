import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DietScreen extends StatefulWidget {
  @override
  _DietScreenState createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedMonth = 'All';

  final List<String> _months = [
    'All', '1st Month', '2nd Month', '3rd Month', '4th Month', '5th Month', '6th Month', '7th Month', '8th Month', '9th Month'
  ];

  final List<DietTip> _dietTips = [
    DietTip(
      icon: Icons.local_dining,
      title: 'Balanced Meals',
      description: 'Include carbs, proteins, and healthy fats in every meal for balanced nutrition.',
      month: 'All',
    ),
    DietTip(
      icon: Icons.opacity,
      title: 'Stay Hydrated',
      description: 'Drink at least 8 glasses of water daily to keep your body hydrated.',
      month: 'All',
    ),
    DietTip(
      icon: Icons.emoji_food_beverage,
      title: 'Limit Caffeine',
      description: 'Reduce coffee and caffeinated beverages to avoid dehydration and anxiety.',
      month: '1st Month',
    ),
    DietTip(
      icon: Icons.local_florist,
      title: 'Eat Fresh Fruits & Veggies',
      description: 'Eat citrus fruits and leafy greens to support baby’s organ development in the 2nd month.',
      month: '2nd Month',
    ),
    DietTip(
      icon: Icons.no_food,
      title: 'Avoid Junk Food',
      description: 'Stay away from processed and high-sugar foods to reduce risk of gestational diabetes.',
      month: '3rd Month',
    ),
    DietTip(
      icon: Icons.nature,
      title: 'Include Whole Grains',
      description: 'Brown rice, oats, and whole wheat help maintain steady energy levels during the 4th month.',
      month: '4th Month',
    ),
  ];

  List<DietTip> _filteredTips = [];

  @override
  void initState() {
    super.initState();
    _filteredTips = _dietTips;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterTips();
  }

  void _filterTips() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTips = _dietTips.where((tip) {
        final matchesMonth = _selectedMonth == 'All' || tip.month == _selectedMonth;
        final matchesSearch = tip.title.toLowerCase().contains(query) ||
            tip.description.toLowerCase().contains(query);
        return matchesMonth && matchesSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.purple, AppColors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('Set Your Diet Plan', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedMonth,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: _months.map((month) {
                      return DropdownMenuItem(value: month, child: Text(month));
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedMonth = value;
                          _filterTips();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search diet tips... ',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _filteredTips.isEmpty
                  ? Center(child: Text('No diet tips found.', style: TextStyle(color: Colors.grey)))
                  : ListView.separated(
                itemCount: _filteredTips.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final tip = _filteredTips[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: AppColors.purple.withOpacity(0.15),
                            child: Icon(tip.icon, color: AppColors.purple, size: 28),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tip.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.purple,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  tip.description,
                                  style: TextStyle(fontSize: 14, color: AppColors.lightText),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DietTip {
  final IconData icon;
  final String title;
  final String description;
  final String month;

  DietTip({
    required this.icon,
    required this.title,
    required this.description,
    required this.month,
  });
}
