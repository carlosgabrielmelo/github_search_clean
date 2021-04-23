import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search_clean/modules/search/domain/entities/result_search.dart';
import 'package:github_search_clean/modules/search/presenter/search/search_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchBloc _searchBloc;

  @override 
  void initState() {
    _searchBloc = Modular.get<SearchBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _searchBloc?.dispose();
    super.dispose();
  }

  Widget _textField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: _searchBloc.searchEvent.add,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Digite o nome do repositório",
            labelText: "Pesquisa"),
      ),
    );
  }

  Widget _items(ResultSearch item) {
    return ListTile(
      leading: Hero(
        tag: item.title,
        child: CircleAvatar(
          backgroundImage: NetworkImage(item?.img ??
              "https://d2v9y0dukr6mq2.cloudfront.net/video/thumbnail/VCHXZQKsxil3lhgr4/animation-loading-circle-icon-on-white-background-with-alpha-channel-4k-video_sjujffkcde_thumbnail-full01.png"),
        ),
      ),
      title: Text(item?.title ?? "title"),
      subtitle: Text(item?.content ?? "content"),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: ListView(
        children: <Widget>[
          _textField(),
          StreamBuilder<List<ResultSearch>>(
              stream: _searchBloc.apiResultFlux,
              builder: (BuildContext context, AsyncSnapshot<List<ResultSearch>> snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          ResultSearch item = snapshot.data[index];
                          return _items(item);
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              }),
        ],
      ),
    );
  }

}