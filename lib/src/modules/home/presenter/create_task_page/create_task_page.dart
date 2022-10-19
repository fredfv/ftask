import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../core/infra/application/common_state.dart';
import '../../../../core/infra/validators/string_validator.dart';
import '../../../../core/presenter/shared/common_button.dart';
import '../../../../core/presenter/shared/common_loading.dart';
import '../../../../core/presenter/shared/common_scaffold.dart';
import '../../../../core/presenter/shared/common_snackbar.dart';
import '../../../../core/presenter/shared/common_text_form_field.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/lexicon.dart';
import '../../../../core/presenter/theme/responsive_outlet.dart';
import '../../../../core/presenter/theme/size_outlet.dart';
import 'create_task_controller.dart';

class TaskPage extends StatelessWidget {
  final CreateTaskController controller;

  const TaskPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: Lexicon.taskPage,
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
              validator: (v) => StringValidator(v).validate(),
              controller: controller.titleController,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            CommonTextFormField(
              onFieldSubmitted: controller.setDueDateFocus,
              focusNode: controller.descriptionFocus,
              label: 'Due date',
              validator: (v) => StringValidator(v).validate(),
              controller: controller.dueDateController,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            CommonTextFormField(
              focusNode: controller.dueDateFocus,
              label: 'Description',
              validator: (v) => StringValidator(v).validate(),
              controller: controller.descriptionController,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05),
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  if (state is LoadingState) {
                    return CommonLoading(ResponsiveOutlet.loadingResponsiveSize(context, SizeOutlet.loadingForButtons));
                  } else if (state is SuccessState) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(CommonSnackBar(
                          content: Text(state.response.toString()), backgroundColor: ColorOutlet.success));
                      controller.value = IdleState();
                    });
                  } else if (state is ErrorState) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CommonSnackBar(content: Text(state.message), backgroundColor: ColorOutlet.error));
                      controller.value = IdleState();
                    });
                  }
                  return CommonButton(
                    description: 'Create new task',
                    onPressed: () {
                      controller.executeAddNewTask();
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
