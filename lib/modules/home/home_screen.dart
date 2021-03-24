import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/models/blogs_model.dart';
import 'package:sample_flutter_app/modules/blog/blog_screen.dart';
import 'package:sample_flutter_app/modules/home/cubit/cubit.dart';
import 'package:sample_flutter_app/modules/home/cubit/states.dart';
import 'package:sample_flutter_app/shared/components/components.dart';
import 'package:sample_flutter_app/shared/di/di.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di<HomeCubit>()
        ..getAllBlog(
          token: getCurrentToken(context),
        ),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext context, HomeStates state) {},
        builder: (BuildContext context, HomeStates state) {
          var list = HomeCubit.get(context).list;

          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: state is! HomeStateLoading,
              builder: (BuildContext context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    blogItem(list[index], tap: () {
                  navigateTo(
                    context,
                    BlogScreen(id: list[index].id),
                  );
                }),
                separatorBuilder: (BuildContext context, int index) =>
                    myDivider(),
                itemCount: list.length,
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
