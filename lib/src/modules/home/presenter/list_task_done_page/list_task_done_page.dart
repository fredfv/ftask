import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../core/infra/application/common_state.dart';
import '../../../../core/presenter/shared/common_loading.dart';
import '../../../../core/presenter/shared/common_scaffold.dart';
import '../../../../core/presenter/shared/common_snackbar.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/dictionary.dart';
import '../../../../core/presenter/theme/size_outlet.dart';
import 'list_task_done_controller.dart';
import 'widgets/task_done_tile.dart';

class ListTaskDonePage extends StatelessWidget {
  final ListTaskDoneController controller;

  const ListTaskDonePage({Key? key, required this.controller}) : super(key: key);

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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: controller.uploadAndGetAllFromCloudExecute,
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
                    itemCount: controller.list.length,
                    itemBuilder: (context, index) {
                      return TaskDoneTile(
                        taskItem: controller.list[index],
                        onLongPress: () {
                          controller.setOnBoardStatusUsecaseExecute(taskId: controller.list[index].id, onBoard: true);
                        },
                      );
                    }),
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
