import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:task/src/core/domain/dictionary.dart';
import 'package:task/src/core/ui/color_outlet.dart';
import 'package:task/src/core/ui/widgets/common_scaffold.dart';
import 'package:task/src/modules/home/controllers/create_task_controller.dart';

import '../../../core/application/common_state.dart';
import '../../../core/ui/size_outlet.dart';
import '../../../core/ui/widgets/common_button.dart';
import '../../../core/ui/widgets/common_loading.dart';
import '../../../core/ui/widgets/common_snackbar.dart';
import '../../../core/ui/widgets/common_text_form_field.dart';

class TaskPage extends StatelessWidget {
  final CreateTaskController controller;
  const TaskPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: Dictionary.taskPage,
      body: Form(
        key: controller.form,
        child: ListView(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.03,
              horizontal: MediaQuery.of(context).size.width * 0.05),
          children: [
            CommonTextFormField(
              onFieldSubmitted: controller.setDescriptionFocus,
              label: 'Title',
              value: controller.newTask.title.toString(),
              validator: (v) => controller.newTask.title.validator(),
              onChanged: controller.newTask.setTitle,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            CommonTextFormField(
              onFieldSubmitted: controller.setDueDateFocus,
              focusNode: controller.descriptionFocus,
              label: 'Due date',
              value: controller.newTask.dueDate.toString(),
              validator: (v) => controller.newTask.dueDate.validator(),
              onChanged: controller.newTask.setDueDate,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            CommonTextFormField(
              focusNode: controller.dueDateFocus,
              label: 'Description',
              value: controller.newTask.description.toString(),
              validator: (v) => controller.newTask.description.validator(),
              onChanged: controller.newTask.setDescription,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.05),
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  if (state is LoadingState) {
                    return const CommonLoading(SizeOutlet.loadingForButtons);
                  } else if (state is SuccessState) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(CommonSnackBar(
                          content: Text(state.response.toString()),
                          backgroundColor: ColorOutlet.success));
                      controller.value = IdleState();
                    });
                  } else if (state is ErrorState) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(CommonSnackBar(
                          content: Text(state.message),
                          backgroundColor: ColorOutlet.error));
                      controller.value = IdleState();
                    });
                  }
                  return CommonButton(
                    description: 'Create new task',
                    onPressed: () {
                      controller.executeAddNewTask(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}