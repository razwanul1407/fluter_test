import 'package:fluter_test/features/user_list/presentation/bloc/user_bloc.dart';
import 'package:fluter_test/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/user_list/presentation/pages/user_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
      ),
      home: BlocProvider(
        create: (_) => sl<UserBloc>(),
        child: const UserListPage(),
      ),
    );
  }
}
