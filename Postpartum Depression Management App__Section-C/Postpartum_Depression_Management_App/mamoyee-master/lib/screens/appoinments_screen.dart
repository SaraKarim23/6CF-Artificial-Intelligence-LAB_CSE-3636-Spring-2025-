import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final List<String> categories = [
    'General Physician',
    'Dermatologist',
    'Pediatrician',
    'Dentist',
    'Cardiologist',
    'Gynecologist',
    'Psychiatrist',
    'Orthopedic',
    'ENT Specialist',
    'Neurologist',
    'Ophthalmologist',
  ];

  final Map<String, List<Map<String, String>>> doctors = {
    'General Physician': [
      {'name': 'Dr. Arman Hossain', 'hospital': 'City Health Clinic'},
      {'name': 'Dr. Nafisa Alam', 'hospital': 'Green Hospital'},
    ],
    'Dermatologist': [
      {'name': 'Dr. Samin Akhter', 'hospital': 'SkinCare Hub'},
    ],
    'Pediatrician': [
      {'name': 'Dr. Tanvir Hasan', 'hospital': 'Child Wellness Center'},
    ],
    'Dentist': [
      {'name': 'Dr. Mahin Rahman', 'hospital': 'Dental Care Plus'},
    ],
    'Cardiologist': [
      {'name': 'Dr. Sadia Karim', 'hospital': 'Heart & Vascular Institute'},
    ],
    'Gynecologist': [
      {'name': 'Dr. Lina Begum', 'hospital': 'Women’s Health Clinic'},
    ],
    'Psychiatrist': [
      {'name': 'Dr. Kamrul Hasan', 'hospital': 'Mind Wellness Center'},
    ],
    'Orthopedic': [
      {'name': 'Dr. Zakir Khan', 'hospital': 'Bone & Joint Hospital'},
    ],
    'ENT Specialist': [
      {'name': 'Dr. Rashed Anwar', 'hospital': 'Ear & Nose Care'},
    ],
    'Neurologist': [
      {'name': 'Dr. Shirin Akter', 'hospital': 'Neuro Care Hospital'},
    ],
    'Ophthalmologist': [
      {'name': 'Dr. Farid Uddin', 'hospital': 'Vision Eye Center'},
    ],
  };

  String selectedCategory = 'General Physician';

  // Function to handle category selection
  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  // Function to build doctor list for the selected category
  Widget buildDoctorList() {
    final selectedDoctors = doctors[selectedCategory] ?? [];

    if (selectedDoctors.isEmpty) {
      return const Center(child: Text("No doctors available in this category."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: selectedDoctors.length,
      itemBuilder: (context, index) {
        final doctor = selectedDoctors[index];

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.2),
              child: const Icon(Icons.person, color: Colors.black87),
            ),
            title: Text(doctor['name']!),
            subtitle: Text(doctor['hospital']!),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Appointment Booked!"),
                    content: Text("You have booked an appointment with ${doctor['name']}"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      )
                    ],
                  ),
                );
              },
              child: const Text("Book"),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Doctor Appointment"),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Categories
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;

                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) => selectCategory(category),
                  selectedColor: AppColors.primary.withOpacity(0.8),
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                );
              },
            ),
          ),
          const Divider(),
          // Doctors List
          Expanded(child: buildDoctorList()),
        ],
      ),
    );
  }
}
