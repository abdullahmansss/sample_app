import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/models/blogs_model.dart';
import 'package:sample_flutter_app/modules/home/cubit/states.dart';
import 'package:sample_flutter_app/shared/network/repository.dart';

class HomeCubit extends Cubit<HomeStates>
{
  final Repository _repository;

  HomeCubit(this._repository) : super(HomeStateInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<BlogsModel> list = [];

  getAllBlog({
    @required String token,
  }) async
  {
    emit(HomeStateLoading());

    final f = await _repository.getAllBlog(
      token: token,
    );

    f.fold(
      (l) async {
        emit(HomeStateError(l));
      },
      (r) async
      {
        list = r;
        emit(HomeStateSuccess());
      },
    );
  }
}
