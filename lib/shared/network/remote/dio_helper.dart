import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:sample_flutter_app/shared/network/errors.dart';

abstract class DioHelper {
  Future<dynamic> postData({
    @required String url,
    @required dynamic data,
  });

  Future<dynamic> getData({
    @required String url,
    dynamic query,
    String token,
  });
}

class DioImpl extends DioHelper {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://60585b2ec3f49200173adcec.mockapi.io/',
      receiveDataWhenStatusError: true,
    ),
  );

  @override
  Future postData({
    String url,
    dynamic data,
  }) async {
    return await _request(
      () async => await dio.post(url, data: data),
    );
  }

  @override
  Future getData({
    String url,
    dynamic query,
    String token,
  }) async {
    if (token != null) {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
    }

    return await _request(
      () async => await dio.get(url, queryParameters: query),
    );
  }
}

extension on DioHelper {
  Future _request(Future<Response> request()) async {
    try {
      final r = await request.call();
      return r.data;
    } on DioError catch (e) {
      throw ServerException(e.response.data);
    } catch (e) {
      throw Exception();
    }
  }
}
