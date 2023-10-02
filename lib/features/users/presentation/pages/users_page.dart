import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud/features/users/domain/entities/user.dart';
import 'package:crud/features/users/presentation/blocs/users/users_bloc.dart';
import 'package:crud/features/users/presentation/pages/user_page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final List<User> users = [];

  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserPage()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is GettingUsers) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserTable) {
            users.clear();
            users.addAll(state.users);

            return Container(
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(users[index].id),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      // Aquí puedes agregar la lógica para eliminar el usuario
                      setState(() {
                        users.removeAt(index);
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text('ID: ${users[index].id}'),
                        subtitle: Text('Nombre: ${users[index].name}'),
                        onTap: () {
                          User user = users[index];
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserPage(user: user)),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is ErrorGettingUsers) {
            return Center(
              child: Text(state.message, style: TextStyle(color: Colors.red)),
            );
          } else {
            return Container();
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const UserPage()),
      //     );
      //   },
      //   backgroundColor: Colors.blue,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
