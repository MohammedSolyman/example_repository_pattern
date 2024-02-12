import 'package:flutter/material.dart';
import 'package:my_repository/my_bloc/my_bloc_bloc.dart';
import 'package:my_repository/providers/my_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_repository/repository/repository.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider<MyRepo>(
        create: (context) => MyRepo(MyProvider()),
        child: BlocProvider<MyBlocBloc>(
          create: (context) => MyBlocBloc(context.read<MyRepo>()),
          child: const MyHome(),
        ),
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        context.read<MyBlocBloc>().add(LoadEvent());
      }),
      body: Center(child: BlocBuilder<MyBlocBloc, MyBlocState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }
          if (state is SuccessState) {
            if (state.productList.isEmpty) {
              return const Text('no data');
            } else {
              return ListView.builder(
                itemCount: state.productList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(state.productList[index].image!)),
                      title: Text(state.productList[index].title!),
                    ),
                  );
                },
              );
            }
          }
          if (state is ErrorState) {
            return Text(state.errorMessage);
          }
          return SizedBox();
        },
      )),
    );
  }
}
