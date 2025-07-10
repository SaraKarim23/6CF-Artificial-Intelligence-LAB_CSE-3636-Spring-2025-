import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../theme/app_colors.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({Key? key}) : super(key: key);

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  final List<Map<String, dynamic>> meditations = [
    {
      'title': 'Mindfulness Meditation',
      'description': 'Focus on the present moment without judgment.',
      'icon': Icons.self_improvement,
      'duration': 60
    },
    {
      'title': 'Breathing Exercises',
      'description': 'Practice deep and rhythmic breathing.',
      'icon': Icons.air,
      'duration': 90
    },
    {
      'title': 'Guided Imagery',
      'description': 'Visualize calming scenes guided by audio.',
      'icon': Icons.image,
      'duration': 120
    },
    {
      'title': 'Body Scan',
      'description': 'Mentally scan your body to release tension.',
      'icon': Icons.spa,
      'duration': 90
    },
    {
      'title': 'Loving-Kindness Meditation',
      'description': 'Cultivate compassion for yourself and others.',
      'icon': Icons.favorite,
      'duration': 90
    },
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();
  int? activeTimerIndex;
  Timer? meditationTimer;
  int timeRemaining = 0;
  Map<int, int> completedSessions = {};

  void startMeditation(int index) {
    setState(() {
      activeTimerIndex = index;
      timeRemaining = meditations[index]['duration'];
    });

    meditationTimer?.cancel();
    meditationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining > 0) {
        setState(() => timeRemaining--);
      } else {
        timer.cancel();
        _onMeditationComplete(index);
      }
    });

    // Placeholder: Play silent bell (replace with real asset)
    _audioPlayer.play(AssetSource('by-the-pond-53620.mp3')).catchError((e) {});
  }

  void _onMeditationComplete(int index) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${meditations[index]['title']} completed!'),
    ));

    setState(() {
      completedSessions[index] = (completedSessions[index] ?? 0) + 1;
      activeTimerIndex = null;
    });
  }

  @override
  void dispose() {
    meditationTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meditation"),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: meditations.length,
          itemBuilder: (context, index) {
            final meditation = meditations[index];
            final isActive = index == activeTimerIndex;

            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Icon(meditation['icon'], color: AppColors.primary),
                ),
                title: Text(meditation['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(meditation['description']),
                    if (completedSessions[index] != null)
                      Text("Completed: ${completedSessions[index]}x", style: const TextStyle(fontSize: 12)),
                    if (isActive)
                      Text("Time left: $timeRemaining sec", style: const TextStyle(color: Colors.red)),
                  ],
                ),
                trailing: isActive
                    ? const Icon(Icons.pause_circle, color: Colors.grey)
                    : const Icon(Icons.play_circle_fill, color: Colors.green),
                onTap: () => startMeditation(index),
              ),
            );
          },
        ),
      ),
    );
  }
}
