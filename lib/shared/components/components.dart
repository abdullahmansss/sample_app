import 'package:flutter/material.dart';
import 'package:sample_flutter_app/models/blogs_model.dart';
import 'package:sample_flutter_app/shared/cubit/cubit.dart';
import 'package:sample_flutter_app/shared/di/di.dart';
import 'package:sample_flutter_app/shared/network/local/cache_helper.dart';

Widget defaultTextForm({
  @required TextEditingController controller,
  @required TextInputType type,
  @required String validation,
  @required String label,
  @required IconData icon,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: (value) {
        if (value.isEmpty) {
          return validation;
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(
          icon,
        ),
      ),
    );

void hideKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

String getCurrentToken(context) => AppCubit.get(context).token;

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

bool isLogin = false;

void checkUserLogin() {
  di<CacheHelper>().has('token').then((value) {
    if (value) {
      isLogin = true;
      // getToken().then((value)
      // {
      //   token = value;
      // });
    } else
      isLogin = false;
  });
}

Widget blogItem(
  BlogsModel model, {
  @required Function tap,
}) =>
    InkWell(
      onTap: tap,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      model.imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      model.createdAt,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'ID : ${model.id}',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );