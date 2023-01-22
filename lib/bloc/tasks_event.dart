part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {}

class TaskLoadEvent extends TasksEvent {
  final List<Tasks> tasks;
  TaskLoadEvent({
    this.tasks = const [],
  });
}

class TaskAddEvent extends TasksEvent {
  final Tasks task;
  TaskAddEvent({
    required this.task,
  });
}

class TaskDeleteEvent extends TasksEvent {
  final Tasks task;
  TaskDeleteEvent({
    required this.task,
  });
}
