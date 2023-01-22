import 'package:flutter/material.dart';
import 'package:flutter_bloc_tasks/core/colors.dart';
import 'package:flutter_bloc_tasks/models/tasks.dart';

class TaskLists {
  static List<Map<String, dynamic>> tasks = [
    {
      'color': CustomColors.lightBlueColor,
      'icon': Icons.book,
    },
    {
      'color': CustomColors.lightPurpleColor,
      'icon': Icons.fitness_center,
    },
    {
      'color': CustomColors.lightOrangeColor,
      'icon': Icons.music_note,
    },
    {
      'color': CustomColors.lightGreenColor,
      'icon': Icons.coffee,
    },
    {
      'color': CustomColors.lightPinkColor,
      'icon': Icons.movie,
    },
  ];

  static List<Tasks> taskCards = [
    Tasks(
      task: 'Reading',
      howLong: 'one hour',
      color: CustomColors.lightBlueColor,
      icon: Icons.book,
    ),
    Tasks(
      task: 'Watch Movies',
      howLong: '30 minutes',
      color: CustomColors.lightPinkColor,
      icon: Icons.movie,
    ),
    Tasks(
      task: 'Workout',
      howLong: 'one and half hour',
      color: CustomColors.lightPurpleColor,
      icon: Icons.fitness_center,
    ),
  ];
}
