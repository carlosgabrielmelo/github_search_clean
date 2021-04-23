import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:github_search_clean/modules/search/domain/entities/result_search.dart';
import 'package:github_search_clean/modules/search/domain/errors/errors.dart';
import 'package:github_search_clean/modules/search/domain/repositories/search_repository.dart';
import 'package:github_search_clean/modules/search/domain/usecases/search_by_text.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main(){
  group('Testes do usecase SearchByText -', (){
    SearchByText usecase;
    SearchRepository repository = SearchRepositoryMock();

    setUp((){
      usecase = SearchByTextImpl(repository);
    });

    test('deve retornar uma lista de ResultSearch', () async {
      when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
      final result = await usecase("some text");
      expect(result | null, isA<List<ResultSearch>>());
    });

    test('deve retornar um erro caso o texto seja inválido', () async {
      when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
      var result = await usecase(null);
      expect(result.fold(id, id), isA<InvalidTextError>());
      result = await usecase("");
      expect(result.fold(id, id), isA<InvalidTextError>());
    });
  });
}