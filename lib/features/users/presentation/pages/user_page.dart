import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud/features/users/domain/entities/user.dart';
import 'package:crud/features/users/presentation/blocs/user/user_bloc.dart';
import 'package:crud/features/users/presentation/blocs/users/users_bloc.dart';
import 'package:flutter/cupertino.dart';

class UserPage extends StatefulWidget {
  final User? user;

  const UserPage({Key? key, this.user}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController name = TextEditingController();
  // TextEditingController email = TextEditingController();
  // TextEditingController status = TextEditingController();

  bool _showNotification = false;

  @override
  void initState() {
    super.initState();

    if (widget.user != null) {
      name.text = widget.user!.name;
      // email.text = widget.user!.email;
      // status.text = widget.user!.status.toString();
    }
  }

  void _showSavedNotification(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Usuario guardado exitosamente"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Agregar usuario a la lista' : 'Actualizar Usuario a la lista'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
              ),
              SizedBox(height: 15),
              BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserSaved) {
                    setState(() {
                      _showNotification = true;
                    });
                    _showSavedNotification(context);
                  }
                },
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is SavingUser) {
                      return CircularProgressIndicator();
                    } else if (state is ErrorSavingUser) {
                      return Text(state.message, style: TextStyle(color: Colors.red));
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                child: Text('Guardar Usuario'),
                onPressed: () {
                  if (widget.user == null) {
                    String id = DateTime.now().millisecondsSinceEpoch.toString();
                    User user = User(id: id, name: name.text);
                    context.read<UserBloc>().add(PressCreateUserButton(user: user));
                  } else {
                    User user = User(id: widget.user!.id, name: name.text);
                    context.read<UserBloc>().add(PressUpdateUserButton(user: user));
                  }
                  context.read<UsersBloc>().add(GetUsers());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
