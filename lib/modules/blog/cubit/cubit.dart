import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/models/blogs_model.dart';
import 'package:sample_flutter_app/modules/blog/cubit/states.dart';
import 'package:sample_flutter_app/shared/network/repository.dart';

class BlogCubit extends Cubit<BlogStates>
{
  final Repository _repository;

  BlogCubit(this._repository) : super(BlogStateInitial());

  static BlogCubit get(context) => BlocProvider.of(context);

  BlogsModel blog;

  getSingleBlog({
    @required String token,
    @required String id,
  }) async
  {
    emit(BlogStateLoading());

    final f = await _repository.getSingleBlog(
      token: token,
      id: id,
    );

    f.fold(
      (l) async {
        emit(BlogStateError(l));
      },
      (r) async
      {
        blog = r;
        emit(BlogStateSuccess());
      },
    );
  }
}