import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_clean/modules/search/domain/errors/errors.dart';
import 'package:github_search_clean/modules/search/external/datasources/github_datasource.dart';
import 'package:github_search_clean/modules/search/infra/models/result_search_model.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/external/datasources/github_datasource_fixture.dart';

main(){
  group('Testes do external GithubDatasource -', (){
    final dio = Dio();
    final dioAdapter = DioAdapterMockito();

    dio.httpClientAdapter = dioAdapter;

    final datasource = GithubDatasource(dio);

    setUp((){
      final responsePayload = dataSuccess;

      final responseBody = ResponseBody.fromString(
        responsePayload,
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );

      when(dioAdapter.fetch(any, any, any)).thenAnswer((_) async => responseBody);
    });

    test('deve retornar uma lista de ResultSearchModel', () async {
      final result = await datasource.getSearch('some text');

      expect(result, isA<List<ResultSearchModel>>());
    });
  });

  group('Testes do external GithubDatasource -', (){
    final dio = Dio();
    final dioAdapter = DioAdapterMockito();

    dio.httpClientAdapter = dioAdapter;

    final datasource = GithubDatasource(dio);

    setUp((){
      final responsePayload = '';

      final responseBody = ResponseBody.fromString(
        responsePayload,
        401,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );

      when(dioAdapter.fetch(any, any, any)).thenThrow(DioError(type: DioErrorType.RESPONSE, error: responseBody));
    });

    test('deve retornar um DatasourceError se o código não for 200', () async {
      final future = datasource.getSearch('some text');

      expect(future, throwsA(isA<DataSourceError>()));
    });
  });
}