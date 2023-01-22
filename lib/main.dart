import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tasks/bloc/tasks_bloc.dart';
import 'package:flutter_bloc_tasks/core/colors.dart';
import 'package:flutter_bloc_tasks/core/lists.dart';

import 'screens/tasks_home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc()..add(TaskLoadEvent(
        tasks: TaskLists.taskCards,
      )),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: CustomColors.primarySwatch,
        ),
        debugShowCheckedModeBanner: false,
        home: const TasksHome(),
      ),
    );
  }
}
