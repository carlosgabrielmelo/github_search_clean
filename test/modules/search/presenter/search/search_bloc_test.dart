
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_clean/modules/search/domain/entities/result_search.dart';
import 'package:github_search_clean/modules/search/domain/errors/errors.dart';
import 'package:github_search_clean/modules/search/domain/usecases/search_by_text.dart';
import 'package:github_search_clean/modules/search/presenter/search/search_bloc.dart';
import 'package:mockito/mockito.dart';

class SearchUsecaseMock extends Mock implements SearchByTextImpl {}

main(){
  final usecase = SearchUsecaseMock();
  SearchBloc searchBloc;

  group('Testes do bloc SearchBloc -', (){   

    setUp((){
      searchBloc = SearchBlocImpl(usecase);
    });

    test('deve retornar uma lista ResultSearch', () async {
      when(usecase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
      searchBloc.searchEvent.add('some text');
      expect(searchBloc.apiResultFlux, emits(isA<List<ResultSearch>>()));
    });

    test('deve limpar a lista caso seja retornado um erro', () async {
      when(usecase.call(any)).thenAnswer((_) async => Left(DataSourceError()));
      searchBloc.searchEvent.add('some text');
      expect(searchBloc.apiResultFlux, emits(isA<List<ResultSearch>>()));
    });
  });
}