import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tasks/bloc/tasks_bloc.dart';
import 'package:flutter_bloc_tasks/core/colors.dart';
import 'package:flutter_bloc_tasks/core/lists.dart';
import 'package:flutter_bloc_tasks/models/tasks.dart';
import 'package:flutter_bloc_tasks/screens/custom_text_field.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TasksHome extends StatelessWidget {
  const TasksHome({super.key});
  static final TextEditingController _taskController = TextEditingController();
  static final TextEditingController _howLongController =
      TextEditingController();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            _tasksHeader(),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Tasks',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            Container(
              height: size.height * 0.10,
              width: double.infinity,
              child: Card(
                elevation: 4,
                color: CustomColors.cardColor,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: TaskLists.tasks.length,
                  itemBuilder: (context, index) {
                    final task = TaskLists.tasks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: GestureDetector(
                        onTap: () {
                          // popup bottom sheet to add tasks
                          _showAddTasksSheet(
                              context, task['color'], task['icon']);
                        },
                        child: CircleAvatar(
                          backgroundColor: task['color'],
                          radius: 20,
                          child: Icon(
                            task['icon'],
                            size: 28,
                            color: CustomColors.iconWhiteColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<TasksBloc, TasksState>(
                builder: (context, state) {
                  if (state is TasksLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.purple),
                    );
                  }

                  if (state is TasksLoadedState) {
                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final card = state.tasks[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 1.5),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.2,
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    BlocProvider.of<TasksBloc>(context)
                                        .add(TaskDeleteEvent(task: card));
                                  },
                                  icon: Icons.close,
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                )
                              ],
                            ),
                            child: Card(
                              color: card.color,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          card.icon,
                                          color: CustomColors.iconWhiteColor,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          card.task!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: CustomColors.iconWhiteColor,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(card.howLong!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: CustomColors.iconWhiteColor,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _tasksHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.dashboard_outlined,
          size: 30,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('EEE').format(DateTime.now()),
                  style: TextStyle(
                    color: CustomColors.greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  DateFormat('MMM, yy').format(DateTime.now()),
                  style: TextStyle(
                    color: CustomColors.greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Text(
              DateFormat('dd').format(DateTime.now()),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showAddTasksSheet(context, color, icon) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Wrap(
              children: [
                Center(
                  child: Transform(
                    transform: Matrix4.translationValues(0, -30, 0),
                    child: CircleAvatar(
                      backgroundColor: CustomColors.backgroundColor,
                      radius: 40,
                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: 36,
                        child: Icon(
                          icon,
                          size: 40,
                          color: CustomColors.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          title: 'Task Name:',
                          hintText: 'eg: reading a book',
                          color: color,
                          controller: _taskController,
                          validator: (value) {
                            if (value == '') {
                              return "Task field is required";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          title: 'How Long:',
                          hintText: 'eg: half an hour',
                          color: color,
                          controller: _howLongController,
                          validator: (value) {
                            if (value == '') {
                              return "How Long field is required";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        _elevatedButton(color, icon),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          );
        });
  } // Its time to start bloc

  _elevatedButton(color, icon) {
    return Container(
      height: 50,
      width: double.infinity,
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Tasks task = Tasks(
                    task: _taskController.text,
                    howLong: _howLongController.text,
                    color: color,
                    icon: icon);
                BlocProvider.of<TasksBloc>(context).add(
                  TaskAddEvent(task: task),
                );
                // empty texts
                _taskController.text = '';
                _howLongController.text = '';
                // pop out from bottom sheet
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                )),
            child: const Text(
              'Let\s Go',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
