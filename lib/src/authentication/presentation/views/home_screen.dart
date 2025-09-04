import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_architecture/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tdd_architecture/src/authentication/presentation/views/widgets/add_user_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }


  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }else if(state is UserCreated){
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Home Screen"),
          ),
          body: state is GettingUsers? const Center(child: CircularProgressIndicator(),):
          state is UsersLoaded? Center(
            child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(state.users[index].avatar),
                ),
                title: Text(state.users[index].name),
              );
            }),
          ):state is CreatingUser?const Center(child: CircularProgressIndicator(),):SizedBox(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                  context: context, builder: (context) => AddUserDialog(nameController: nameController,));
              // context.read<AuthenticationCubit>().createUser(createdAt: DateTime.now().toString(), name:"Furqan", avatar: "");
            },
            icon: Icon(Icons.add),
            label: Text("Add User"),
          ),
        );
      },
    );
  }
}
