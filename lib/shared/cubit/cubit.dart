import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/shared/cubit/states.dart';
import 'package:sample_flutter_app/shared/di/di.dart';
import 'package:sample_flutter_app/shared/network/local/cache_helper.dart';
import 'package:sample_flutter_app/shared/network/repository.dart';

class AppCubit extends Cubit<AppStates> {
  final Repository _repository;

  AppCubit(this._repository) : super(AppStateInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  String token = '';

  Future<String> getToken() async
  {
    final token = await di<CacheHelper>().get('token');
    return token;
  }
}