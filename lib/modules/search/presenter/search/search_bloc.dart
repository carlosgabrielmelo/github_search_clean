import 'dart:async';
import 'package:github_search_clean/modules/search/domain/entities/result_search.dart';
import 'package:github_search_clean/modules/search/domain/usecases/search_by_text.dart';
import 'package:rxdart/rxdart.dart';

abstract class SearchBloc {
  // ignore: close_sinks
  BehaviorSubject<String> _searchController;
  Stream<String> get searchFlux => _searchController.stream;
  Sink<String> get searchEvent => _searchController.sink;
  Stream<List<ResultSearch>> apiResultFlux;
  void dispose();
}

class SearchBlocImpl implements SearchBloc {
  SearchByText usecase;
  BehaviorSubject<String> _searchController = BehaviorSubject<String>();
  Stream<String> get searchFlux => _searchController.stream;
  Sink<String> get searchEvent => _searchController.sink;

  Stream<List<ResultSearch>> apiResultFlux;

  SearchBlocImpl(this.usecase){
    apiResultFlux = searchFlux
      .distinct()
      .where((response) => response.length>2)
      .debounceTime(Duration(milliseconds: 500))
      .asyncMap(usecase)
      .switchMap((result) => result.fold((l) => Stream.value(<ResultSearch>[]), (r) => Stream.value(r)));
  }

  void dispose(){
    _searchController?.close();
  }
}