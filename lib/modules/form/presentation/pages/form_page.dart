import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/modules/detail/presentation/manager/detail_bloc.dart';
import 'package:task_manager/modules/home/presentation/manager/home_bloc.dart';

import '../manager/form_bloc.dart';

@RoutePage()
class FormPage extends StatefulWidget {
  const FormPage({
    super.key,
    this.id,
  });

  final int? id;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      context.read<FormBloc>().add(FetchTaskByIdFormEvent(widget.id!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Task',
        ),
      ),
      body: BlocBuilder<FormBloc, FormPageState>(
        builder: (context, state) {
          return Form(
            key: context.read<FormBloc>().formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ),
                  child: TextFormField(
                    controller: context.read<FormBloc>().titleController,
                    onTapOutside: (pointer) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: const InputDecoration(
                      labelText: "Titre",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    validator: (value) {
                      if (value == null || value == "") return "Bad format";
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: context.read<FormBloc>().descriptionController,
                    maxLines: 10,
                    onTapOutside: (pointer) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: const InputDecoration(
                      labelText: "Description",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    validator: (value) {
                      if (value == null || value == "") return "Bad format";
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (context
                        .read<FormBloc>()
                        .formKey
                        .currentState!
                        .validate()) {
                      context.read<FormBloc>().add(const SaveFormEvent());
                      context
                          .read<HomeBloc>()
                          .add(const FetchTaskHomeEvent(null));
                      if (widget.id != null) {
                        context
                            .read<DetailBloc>()
                            .add(FetchTaskByIdDetailEvent(widget.id!));
                      }

                      context.router.popForced();
                    }
                  },
                  child: const Text(
                    "Enregistrer",
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
