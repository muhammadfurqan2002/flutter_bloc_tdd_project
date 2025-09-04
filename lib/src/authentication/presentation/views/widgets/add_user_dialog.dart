import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_architecture/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatefulWidget {
  final TextEditingController nameController;
  const AddUserDialog({super.key,required this.nameController});

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: widget.nameController,
                decoration: InputDecoration(
                  labelText: "username"
                ),
              ),
              ElevatedButton(onPressed: (){
                final name=widget.nameController.text.trim();
                context.read<AuthenticationCubit>().createUser(createdAt: DateTime.now().toString(), name: name, avatar: "https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/47.jpg");
              }, child: Text("Add User"))
            ],
          ),
        ),
      ),
    );
  }
}
