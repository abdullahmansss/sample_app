import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/modules/home/home_screen.dart';
import 'package:sample_flutter_app/modules/login/cubit/cubit.dart';
import 'package:sample_flutter_app/modules/login/cubit/states.dart';
import 'package:sample_flutter_app/shared/components/components.dart';
import 'package:sample_flutter_app/shared/di/di.dart';
import 'package:sample_flutter_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, LoginStates state)
        {
          if (state is LoginStateSuccess)
          {
            di<CacheHelper>().put('token', state.token).then((value)
            {
              navigateAndFinish(
                context,
                HomeScreen(),
              );
            });
          }
        },
        builder: (BuildContext context, LoginStates state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultTextForm(
                          controller: emailController,
                          icon: Icons.email,
                          label: 'Email Address',
                          type: TextInputType.emailAddress,
                          validation: 'email address must not be empty',
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          controller: passwordController,
                          icon: Icons.lock,
                          label: 'Password',
                          type: TextInputType.visiblePassword,
                          validation: 'password must not be empty',
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginStateLoading,
                          builder: (BuildContext context) => Container(
                            width: double.infinity,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(
                                3.0,
                              ),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  hideKeyboard(context);

                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: Text(
                                'login',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          fallback: (BuildContext context) =>
                              CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
