import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mangamint/bloc/manga_detail_bloc/bloc.dart';
import 'package:mangamint/components/loading_dialog.dart';
import 'package:mangamint/screens/detail_screen/manga_detail_screen.dart';

class IndexDetail extends StatefulWidget {
  final String endpoint;

  const IndexDetail({Key key, this.endpoint}) : super(key: key);

  @override
  _IndexDetailState createState() => _IndexDetailState();
}

class _IndexDetailState extends State<IndexDetail> {
  MangaDetailBloc _mangaDetailBloc;
  var manga = Hive.box('manga');
  String get endpoint => widget.endpoint;
  @override
  void initState() {
    super.initState();
//    manga.put('endpoint', endpoint);
    _mangaDetailBloc = BlocProvider.of<MangaDetailBloc>(context);
    _mangaDetailBloc.add(FetchMangaDetail(endpoint));
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangaDetailBloc,MangaDetailState>(
      builder: (context, state){
        if(state is MangaDetailLoadingState){
          return LoadingDialog();
        }else if(state is MangaDetailLoadedState){
          return MangaDetailScreen(data:state.data);
        }else if(state is MangaDetailFailureState){
          return Center(child: Text(state.msg),);
        }
        return Container();
      },
    );
  }
}
