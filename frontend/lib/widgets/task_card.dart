import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TaskCard extends StatelessWidget {

  final TaskModel task;

  final VoidCallback onTap;

  final VoidCallback onEdit;

  final VoidCallback onDelete;

  const TaskCard({

    super.key,

    required this.task,

    required this.onTap,

    required this.onEdit,

    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      margin:
      const EdgeInsets.symmetric(

        horizontal: 12,

        vertical: 8,
      ),

      shape:
      RoundedRectangleBorder(

        borderRadius:
        BorderRadius.circular(20),
      ),

      child: InkWell(

        borderRadius:
        BorderRadius.circular(20),

        onTap: onTap,

        child: Padding(

          padding:
          const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment
                .start,

            children: [

              Row(

                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

                children: [

                  Expanded(

                    child: Text(

                      task.title,

                      style:
                      const TextStyle(

                        fontSize: 22,

                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),
                  ),

                  PopupMenuButton(

                    itemBuilder:
                        (context) => [

                      PopupMenuItem(

                        onTap: onEdit,

                        child:
                        const Text(
                          'Edit',
                        ),
                      ),

                      PopupMenuItem(

                        onTap:
                        onDelete,

                        child:
                        const Text(
                          'Delete',
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text(task.description),

              const SizedBox(height: 20),

              Row(

                children: [

                  const Icon(
                    Icons.calendar_today,
                    size: 18,
                  ),

                  const SizedBox(width: 10),

                  Text(task.dueDate),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}