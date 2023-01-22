part of 'tasks_bloc.dart';

@immutable
abstract class TasksState {
  final List<Tasks> tasks;
  TasksState({
    this.tasks = const [],
  });
}

class TasksLoadingState extends TasksState {}

class TasksLoadedState extends TasksState {
  final List<Tasks> tasks;
  TasksLoadedState({
    this.tasks = const [],
  });
}
