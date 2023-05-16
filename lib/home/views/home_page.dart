import 'package:advisoryapps/authentication/authentication.dart';
import 'package:advisoryapps/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<ListItemBloc>().add(GetListItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Page'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(LogOut());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<ListItemBloc, ListItemState>(
        builder: (context, state) {
          switch (state.status) {
            case ListItemStatus.initial:
            case ListItemStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ListItemStatus.completed:
              return ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final name = state.items[index].listName;
                    final distance = state.items[index].distance;
                    return ListTile(
                      leading: const Icon(Icons.food_bank),
                      title: Text(name),
                      trailing: Text(distance),
                      onTap: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Name: $name, Distance: $distance'),
                          ),
                        );
                      },
                    );
                  });
            case ListItemStatus.error:
              return Center(
                child: Text(state.error.message),
              );
          }
        },
      ),
    );
  }
}
