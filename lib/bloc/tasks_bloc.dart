import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_tasks/models/tasks.dart';
import 'package:meta/meta.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksLoadedState()) {
    on<TaskLoadEvent>((event, emit) {
      emit(TasksLoadedState(tasks: event.tasks));
    });
    // Add tasks
    on<TaskAddEvent>((event, emit) {
      emit(TasksLoadedState(tasks: List.from(state.tasks)..add(event.task)));
    });
    // Remove tasks
    on<TaskDeleteEvent>((event, emit) {
      List<Tasks> tasks =
          state.tasks.where((task) => task.task != event.task.task).toList();
      emit(TasksLoadedState(tasks: tasks));
    });
  }
}
