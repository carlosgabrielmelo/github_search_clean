import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_clean/app_module.dart';
import 'package:github_search_clean/modules/search/domain/entities/result_search.dart';
import 'package:github_search_clean/modules/search/domain/usecases/search_by_text.dart';
import 'package:mockito/mockito.dart';

import 'fixtures/external/datasources/github_datasource_fixture.dart';

class DioMock extends Mock implements Dio {}

main(){
  final dio = DioMock();

  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test('Deve recuperar o usecase sem erro', (){
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByText>());
  });

  test('Deve trazer uma lista de ResultSearch', () async {
    final usecase = Modular.get<SearchByText>();
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(dataSuccess), statusCode: 200));
    final result = await usecase('some text');
    expect(result | null, isA<List<ResultSearch>>());
  });
}