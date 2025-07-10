import 'package:flutter/material.dart';
import '../theme/app_colors.dart'; // Make sure AppColors.primary and AppColors.white are defined here

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final TextEditingController _controller = TextEditingController();
  DateTime selectedDate = DateTime.now();

  final List<Map<String, dynamic>> diaryEntries = [];

  Set<String> selectedSexDrive = {};
  Set<String> selectedMoods = {};
  Set<String> selectedSymptoms = {};
  Set<String> selectedDischarge = {};
  Set<String> selectedActivity = {};
  Set<String> selectedSupplements = {};
  Set<String> selectedFetalMovement = {};

  final sexOptions = {
    "No Sex": Icons.favorite_border,
    "Protected Sex": Icons.verified_user,
    "Unprotected Sex": Icons.lock_open,
    "Masturbation": Icons.self_improvement,
    "High Sex Drive": Icons.whatshot,
    "Low Sex Drive": Icons.ac_unit,
  };

  final moodOptions = {
    "Happiness & excitement": Icons.emoji_emotions,
    "Sadness & Discomfort": Icons.sentiment_dissatisfied,
    "Anxiety & Stress": Icons.mood_bad,
    "Satisfaction": Icons.thumb_up,
  };

  final symptomOptions = {
    "Missed Period": Icons.event_busy,
    "Nausea & Vomiting": Icons.sick,
    "Fatigue": Icons.battery_alert,
    "Breast changes": Icons.accessibility,
    "Frequent urination": Icons.water,
    "Food cravings or Aversions": Icons.fastfood,
    "Heartburn or indigestion": Icons.local_fire_department,
    "Constipation": Icons.block,
    "Back pain": Icons.back_hand,
    "Headache": Icons.headset,
    "Dizziness": Icons.sync_problem,
    "Shortness of breath": Icons.air,
    "Swelling": Icons.bubble_chart,
    "Skin Changes": Icons.color_lens,
  };

  final dischargeOptions = {
    "Normal discharge": Icons.water_drop,
    "Thin, Watery Discharge": Icons.water,
    "Brown discharge": Icons.opacity,
    "Foul-Smelling Discharge": Icons.warning,
    "Discharge with Blood Streaks": Icons.bloodtype,
    "Thick, White Discharge": Icons.ac_unit,
    "Yellow or Green Discharge": Icons.color_lens,
    "Pink Discharge": Icons.favorite,
    "Heavy Discharge": Icons.shower,
  };

  final activityOptions = {
    "No": Icons.close,
    "Walking": Icons.directions_walk,
    "Pilates": Icons.fitness_center,
    "Swimming": Icons.pool,
    "Yoga": Icons.self_improvement,
    "Aerobics": Icons.directions_run,
    "Streching": Icons.accessibility_new,
    "Cycling": Icons.pedal_bike,
    "Meditation": Icons.spa,
    "Gentle Dancing": Icons.music_note,
    "Others": Icons.more_horiz,
  };

  final supplementOptions = {
    "Folic Acid": Icons.medication,
    "Iron": Icons.monitor_heart,
    "Calcium": Icons.ac_unit,
    "Vitamin D": Icons.wb_sunny,
    "DHA": Icons.science,
    "Magnesium": Icons.auto_fix_high,
    "Vitamin C": Icons.healing,
    "Vitamin B6": Icons.medical_services,
    "Zinc": Icons.invert_colors,
    "Collagen": Icons.join_inner,
    "Prenatal vitamins": Icons.favorite,
  };

  final fetalMovementOptions = {
    "No activity": Icons.close,
    "Less Active": Icons.trending_down,
    "More Active": Icons.trending_up,
    "Hiccup": Icons.bubble_chart,
  };

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF7F00FF), // header color
              onPrimary: Colors.white,   // text on header
              onSurface: Colors.black,   // normal text
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  void saveDiary() {
    final entry = {
      "date": selectedDate,
      "note": _controller.text,
      "sexDrive": selectedSexDrive.toList(),
      "moods": selectedMoods.toList(),
      "symptoms": selectedSymptoms.toList(),
      "discharge": selectedDischarge.toList(),
      "activity": selectedActivity.toList(),
      "supplements": selectedSupplements.toList(),
      "fetalMovement": selectedFetalMovement.toList(),
    };

    setState(() {
      diaryEntries.insert(0, entry);
      _controller.clear();
      selectedSexDrive.clear();
      selectedMoods.clear();
      selectedSymptoms.clear();
      selectedDischarge.clear();
      selectedActivity.clear();
      selectedSupplements.clear();
      selectedFetalMovement.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Diary saved for ${selectedDate.toLocal().toString().split(' ')[0]}")),
    );
  }

  Widget buildOptionGrid(Map<String, IconData> options, Set<String> selectedSet) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.entries.map((entry) {
        final isSelected = selectedSet.contains(entry.key);
        return ChoiceChip(
          label: Text(entry.key),
          avatar: Icon(entry.value, size: 20),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              isSelected ? selectedSet.remove(entry.key) : selectedSet.add(entry.key);
            });
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE14AA7), Color(0xFFAB54EF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 10),
                const Text("Diary",
                    style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _pickDate,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 8),
                        Text(
                          "Date: ${selectedDate.toLocal().toString().split(' ')[0]}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  TextField(
                    controller: _controller,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Write your thoughts...",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: AppColors.white,
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Text("Sex and Sex Drive", style: TextStyle(fontWeight: FontWeight.bold)),
                  buildOptionGrid(sexOptions, selectedSexDrive),

                  const SizedBox(height: 16),
                  const Text("Moods", style: TextStyle(fontWeight: FontWeight.bold)),
                  buildOptionGrid(moodOptions, selectedMoods),

                  const SizedBox(height: 16),
                  const Text("Symptoms", style: TextStyle(fontWeight: FontWeight.bold)),
                  buildOptionGrid(symptomOptions, selectedSymptoms),

                  const SizedBox(height: 16),
                  const Text("Vaginal Discharge", style: TextStyle(fontWeight: FontWeight.bold)),
                  buildOptionGrid(dischargeOptions, selectedDischarge),

                  const SizedBox(height: 16),
                  const Text("Activity", style: TextStyle(fontWeight: FontWeight.bold)),
                  buildOptionGrid(activityOptions, selectedActivity),

                  const SizedBox(height: 16),
                  const Text("Dietary Supplements", style: TextStyle(fontWeight: FontWeight.bold)),
                  buildOptionGrid(supplementOptions, selectedSupplements),

                  const SizedBox(height: 16),
                  const Text("Fetal Movement", style: TextStyle(fontWeight: FontWeight.bold)),
                  buildOptionGrid(fetalMovementOptions, selectedFetalMovement),

                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: saveDiary,
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                      child: const Text("Save Entry"),
                    ),
                  ),

                  const SizedBox(height: 30),
                  if (diaryEntries.isNotEmpty)
                    const Text("Previous Entries", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  ...diaryEntries.map((entry) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text("Date: ${entry['date'].toString().split(' ')[0]}"),
                        subtitle: Text(entry['note'] ?? "No notes"),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
