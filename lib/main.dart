import 'dart:convert';
import 'dart:core';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


import 'flutter_flow/flutter_flow_theme.dart';

import 'package:http/http.dart' as http;
import 'Record.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Future<List<Record>> getRequest() async {
    //replace your restFull API here.
    String url = "http://192.168.0.112:8080/client/getAllRecords";
    final response = await http.get(Uri.parse(url));
    //print(response);
    var responseData = json.decode(response.body);
    //print(responseData);

    //Creating a list to store input data;
    List<Record> ListOfRecords = [];
    for (var singleRecord in responseData) {
      Record record = Record(
        singleRecord['humAr'],
        singleRecord['humSolo'],
        singleRecord['tempAr'],
        singleRecord['luz'],
          singleRecord['maduro'] == "true"? true : false
      );
      ListOfRecords.add(record);
    }
    return ListOfRecords;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'A Minha Estufa',
            style: FlutterFlowTheme.of(context).title1.override(
              fontFamily: 'Outfit',
              color: FlutterFlowTheme.of(context).white,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Container(
              child: FutureBuilder(
                  future: getRequest(),
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 16.0, 0.0),
                              child: Text(
                                'Estes são os valores obtidos do Arduino.',
                                style: FlutterFlowTheme.of(context).subtitle2,
                              )),
                          Divider(
                            height: 4.0,
                            thickness: 1.0,
                            indent: 16.0,
                            endIndent: 16.0,
                            color: FlutterFlowTheme.of(context).lineColor,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 8.0),
                                        child: InkWell(
                                          onTap: () {
                                            print("CLIQUEI Num record");
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme
                                                  .of(context)
                                                  .secondaryBackground,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5.0,
                                                  color: Color(0x230E151B),
                                                  offset: Offset(0.0, 2.0),
                                                )
                                              ],
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      16.0, 8.0, 16.0, 8.0),
                                                  child: Text(
                                                    'Humidade',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(
                                                        context)
                                                        .subtitle2,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      16.0, 0.0, 16.0, 24.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        snapshot.data[index].humAr.toString()
                                                        ,
                                                        style:
                                                        FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .title2,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      16.0, 8.0, 16.0, 8.0),
                                                  child: Text(
                                                    'Temperatura',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(
                                                        context)
                                                        .subtitle2,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      16.0, 0.0, 16.0, 24.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        snapshot.data[index].tempAr.toString(),
                                                        style:
                                                        FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .title2,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),                                      ),
                                        ));
                                  }),
                            ),
                          ),
                        ],
                      );
                    }
                  })),
        ),
      ),
    );
  }
}
