import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/modules/home/home_screen.dart';
import 'package:sample_flutter_app/modules/login/login_screen.dart';
import 'package:sample_flutter_app/shared/components/components.dart';
import 'package:sample_flutter_app/shared/cubit/cubit.dart';
import 'package:sample_flutter_app/shared/cubit/states.dart';
import 'package:sample_flutter_app/shared/di/di.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  checkUserLogin();

  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => di<AppCubit>(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: isLogin ? HomeScreen() : LoginScreen(),
          );
        },
      ),
    );
  }
}