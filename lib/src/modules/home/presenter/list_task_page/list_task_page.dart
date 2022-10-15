import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:task/src/modules/home/presenter/list_task_page/list_task_controller.dart';

import '../../../../core/infra/application/common_state.dart';
import '../../../../core/presenter/shared/common_loading.dart';
import '../../../../core/presenter/shared/common_scaffold.dart';
import '../../../../core/presenter/shared/common_snackbar.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/dictionary.dart';
import '../../../../core/presenter/theme/size_outlet.dart';
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
            return Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 1,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemCount: controller.list.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return TaskTile(taskItem: controller.list[index]);
                  }),
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
