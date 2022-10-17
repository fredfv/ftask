import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../core/infra/application/common_state.dart';
import '../../../../core/presenter/shared/common_loading.dart';
import '../../../../core/presenter/shared/common_scaffold.dart';
import '../../../../core/presenter/shared/common_snackbar.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/dictionary.dart';
import '../../../../core/presenter/theme/size_outlet.dart';
import 'widgets/task_tile.dart';
import 'list_task_controller.dart';

class ListTaskPage extends StatefulWidget {
  final ListTaskController controller;
  const ListTaskPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<ListTaskPage> createState() => _ListTaskPageState();
}

class _ListTaskPageState extends State<ListTaskPage> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: Dictionary.tasksPage,
      body: ValueListenableBuilder(
        valueListenable: widget.controller,
        builder: (_, state, child) {
          if (state is LoadingState) {
            return const Center(child: CommonLoading(SizeOutlet.loadingForButtons));
          } else if (state is SuccessState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: widget.controller.list.length,
                  itemBuilder: (context, index) {
                    return TaskTile(
                      taskItem: widget.controller.list[index],
                      controller: widget.controller.timeElapsedChangeNotifier,
                      onLongPress: () {
                        widget.controller.setOnBoardStatusUsecaseExecute(widget.controller.list[index].id);
                        setState(() {});
                        // ScaffoldMessenger.of(context).showSnackBar(CommonSnackBar(
                        //     content: Text(state.response.toString()), backgroundColor: ColorOutlet.success));
                      },
                    );
                  }),
            );
          } else if (state is ErrorState) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(CommonSnackBar(content: Text(state.message), backgroundColor: ColorOutlet.error));
              widget.controller.value = IdleState();
            });
          }
          return Container();
        },
      ),
    );
  }
}
