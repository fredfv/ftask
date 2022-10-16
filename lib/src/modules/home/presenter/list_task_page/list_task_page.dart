import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../core/infra/application/common_state.dart';
import '../../../../core/presenter/shared/common_loading.dart';
import '../../../../core/presenter/shared/common_scaffold.dart';
import '../../../../core/presenter/shared/common_snackbar.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/dictionary.dart';
import '../../../../core/presenter/theme/size_outlet.dart';
import '../../shared/task_tile.dart';
import 'list_task_controller.dart';

class ListTaskPage extends StatelessWidget {
  final ListTaskController controller;

  const ListTaskPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: Dictionary.tasksPage,
      body: ValueListenableBuilder(
        valueListenable: controller,
        builder: (_, state, child) {
          if (state is LoadingState) {
            return const Center(child: CommonLoading(SizeOutlet.loadingForButtons));
          } else if (state is SuccessState) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    for (final task in controller.list)
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.22,
                        ),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TaskTile(
                            taskItem: task,
                            controller: controller.timeElapsedChangeNotifier,
                            onLongPress: () {
                              controller.setOnBoardStatusUsecaseExecute(task.id);
                              ScaffoldMessenger.of(context).showSnackBar(CommonSnackBar(
                                  content: Text(state.response.toString()), backgroundColor: ColorOutlet.success));
                            }),
                      )
                  ],
                ),
              ),
            );
          } else if (state is ErrorState) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(CommonSnackBar(content: Text(state.message), backgroundColor: ColorOutlet.error));
              controller.value = IdleState();
            });
          }
          return Container();
        },
      ),
    );
  }
}
