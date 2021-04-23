import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search_clean/app_widget.dart';
import 'package:github_search_clean/modules/search/domain/usecases/search_by_text.dart';
import 'package:github_search_clean/modules/search/external/datasources/github_datasource.dart';
import 'package:github_search_clean/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:github_search_clean/modules/search/presenter/search/search_page.dart';
import 'modules/search/presenter/search/search_bloc.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    Bind((i) => Dio()),
    Bind((i) => SearchByTextImpl(i())),
    Bind((i) => SearchRepositoryImpl(i())),
    Bind((i) => GithubDatasource(i())),
    Bind((i) => SearchBlocImpl(i())),
  ];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => SearchPage()),
  ];

}