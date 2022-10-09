import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:task/src/core/domain/dictionary.dart';
import 'package:task/src/core/ui/widgets/common_scaffold.dart';
import 'package:task/src/modules/home/controllers/list_task_controller.dart';

import '../../../core/application/common_state.dart';
import '../../../core/ui/color_outlet.dart';
import '../../../core/ui/size_outlet.dart';
import '../../../core/ui/widgets/common_loading.dart';
import '../../../core/ui/widgets/common_snackbar.dart';
import 'widgets/task_tile.dart';

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
            // return GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //       maxCrossAxisExtent: 200,
            //       childAspectRatio: 1,
            //       crossAxisSpacing: 1,
            //       mainAxisSpacing: 10,
            //     ),
            //     itemCount: controller.list.length,
            //     itemBuilder: (BuildContext ctx, index) {
            //       return TaskTile(taskItem: controller.list[index]);
            //     });

            return ListView.builder(
                itemCount: controller.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return TaskTile(taskItem: controller.list[index]);
                });
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
