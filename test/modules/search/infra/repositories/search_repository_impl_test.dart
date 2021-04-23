import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_clean/modules/search/domain/errors/errors.dart';
import 'package:github_search_clean/modules/search/infra/models/result_search_model.dart';
import 'package:github_search_clean/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:github_search_clean/modules/search/infra/datasources/search_datasource.dart';

class SearchDatasourceMock extends Mock implements SearchDatasource {}

main(){
  group('Testes do repository SearchRepository -', (){
    SearchRepositoryImpl repository;
    SearchDatasourceMock datasource = SearchDatasourceMock();

    setUp((){
      repository = SearchRepositoryImpl(datasource);
    });

    test('deve retornar uma lista ResultSearch', () async {
      when(datasource.getSearch(any)).thenAnswer((_) async => <ResultSearchModel>[]);
      final result = await repository.search('some text');
      expect(result | null, isA<List<ResultSearchModel>>());
    });
    test('deve retornar um DataSourceError se o datasource falhar', () async {
      when(datasource.getSearch(any)).thenThrow(Exception());
      final result = await repository.search('some text');
      expect(result.fold(id, id), isA<DataSourceError>());
    });
  });
}