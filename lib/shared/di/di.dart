import 'package:get_it/get_it.dart';
import 'package:sample_flutter_app/modules/blog/cubit/cubit.dart';
import 'package:sample_flutter_app/modules/home/cubit/cubit.dart';
import 'package:sample_flutter_app/modules/login/cubit/cubit.dart';
import 'package:sample_flutter_app/shared/cubit/cubit.dart';
import 'package:sample_flutter_app/shared/network/local/cache_helper.dart';
import 'package:sample_flutter_app/shared/network/remote/dio_helper.dart';
import 'package:sample_flutter_app/shared/network/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt di = GetIt.I..allowReassignment = true;

Future init() async
{
  final sp = await SharedPreferences.getInstance();

  di.registerLazySingleton<SharedPreferences>(
    () => sp,
  );

  di.registerLazySingleton<CacheHelper>(
    () => CacheImpl(
      di<SharedPreferences>(),
    ),
  );

  di.registerLazySingleton<DioHelper>(
    () => DioImpl(),
  );

  di.registerLazySingleton<Repository>(
    () => RepoImpl(
      dioHelper: di<DioHelper>(),
      cacheHelper: di<CacheHelper>(),
    ),
  );

  di.registerFactory<AppCubit>(
    () => AppCubit(
      di<Repository>(),
    ),
  );

  di.registerFactory<LoginCubit>(
        () => LoginCubit(
      di<Repository>(),
    ),
  );

  di.registerFactory<HomeCubit>(
        () => HomeCubit(
      di<Repository>(),
    ),
  );

  di.registerFactory<BlogCubit>(
        () => BlogCubit(
      di<Repository>(),
    ),
  );
}
