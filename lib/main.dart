import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_info_assignment/bloc/person_info/person_info_bloc.dart';
import 'package:person_info_assignment/model/PersonInfoModel.dart';

import 'detail-add.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(),
        home: BlocProvider(
          create: (BuildContext context) => PersonInfoBloc(),
          child: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  PersonInfoBloc _personInfoBloc;

  @override
  Widget build(BuildContext context) {
    _personInfoBloc = BlocProvider.of<PersonInfoBloc>(context);
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Person Info App',
        )),
        body: BlocBuilder(
          bloc: _personInfoBloc,
          builder: (BuildContext context, PersonInfoState state) {
            if (state is InitialPersonInfoState) {
              _personInfoBloc.add(LoadInfo());
              return SizedBox();
            }
            if (state is LoadedPersonInfoState) {
              var info = state.personInfoModel.personInfo;
              if (info.length == 0) return SizedBox();
              return buildToDo(info);
            }
            return CircularProgressIndicator();
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => BlocProvider.value(
                        value: _personInfoBloc,
                        child: DetailAddPage(personInfo: null))));
          },
        ));
  }

  Widget buildToDo(List<PersonInfo> item) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: item.length,
        itemBuilder: (BuildContext context, int index) {
          final info = item[index];
          return Card(
            color: Colors.grey.shade200,
            elevation: 8.0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => BlocProvider.value(
                            value: _personInfoBloc,
                            child: DetailAddPage(personInfo: info))));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 7),
                    Text("${info.firstName} ${info.lastName}"),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
