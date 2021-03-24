import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/models/blogs_model.dart';
import 'package:sample_flutter_app/modules/blog/cubit/cubit.dart';
import 'package:sample_flutter_app/modules/blog/cubit/states.dart';
import 'package:sample_flutter_app/modules/home/cubit/cubit.dart';
import 'package:sample_flutter_app/modules/home/cubit/states.dart';
import 'package:sample_flutter_app/shared/components/components.dart';
import 'package:sample_flutter_app/shared/di/di.dart';

class BlogScreen extends StatelessWidget {
  final String id;

  const BlogScreen({
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di<BlogCubit>()
        ..getSingleBlog(
          token: getCurrentToken(context),
          id: this.id,
        ),
      child: BlocConsumer<BlogCubit, BlogStates>(
        listener: (BuildContext context, BlogStates state) {},
        builder: (BuildContext context, BlogStates state)
        {
          var blog = BlogCubit.get(context).blog;

          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: state is! BlogStateLoading,
              builder: (BuildContext context) => blogItem(
                blog,
                tap: () {},
              ),
              fallback: (BuildContext context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}