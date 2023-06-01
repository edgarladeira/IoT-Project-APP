import 'dart:convert';
import 'dart:core';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


import 'flutter_flow/flutter_flow_theme.dart';

import 'package:http/http.dart' as http;
import 'Record.dart';
import 'flutter_flow/flutter_flow_util.dart';

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

    var responseData = json.decode(response.body);

    //Record record = Record(123, 321, 456, 654, false, );
    //Creating a list to store input data;
    List<Record> ListOfRecords = [];
    //ListOfRecords.add(record);
    print(responseData);
    for (var singleRecord in responseData) {

      var milliseconds = singleRecord['created']['seconds'] * 1000 + (singleRecord['created']['nanoseconds'] / 1000000).round();
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);

      print(DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime));


      Record record = Record(
        singleRecord['humAr'],
        singleRecord['humSolo'],
        singleRecord['tempAr'],
        singleRecord['luz'],
        singleRecord['maduro'] == "true"? true : false,
        dateTime,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 16.0, 0.0),
                              child: Text(
                                'Estes são os valores obtidos do Arduino:',
                                style: FlutterFlowTheme.of(context).title3,
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
                                    //print(snapshot.data.length);

                                    return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 8.0),
                                        child: InkWell(
                                          onTap: () {
                                            print("CLIQUEI Num record");
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0),
                                                child: Text(
                                                  'Dia ${DateFormat('dd-MM-yyyy').format(snapshot.data[index].data)}',
                                                  style:
                                                  FlutterFlowTheme
                                                      .of(
                                                      context)
                                                      .title3,
                                                ),
                                              ),
                                              Container(
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
                                                          0.0, 8.0, 0.0, 8.0),
                                                      child: Text(
                                                        'Hora',
                                                        style:
                                                        FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .title3,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                      child: Text(
                                                        DateFormat('HH:mm').format(snapshot.data[index].data),
                                                        style:
                                                        FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .title2,
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 16.0, 0.0, 0.0),
                                                      child: Text(
                                                        'Humidade do Ar',
                                                        style:
                                                        FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .title3,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 16.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,

                                                        children: [
                                                          Image(image: AssetImage('images/humAr.png'), height: 45,),
                                                          Container(
                                                            width: 5,
                                                          ),
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
                                                          0.0, 8.0, 0.0, 8.0),
                                                      child: Text(
                                                        'Humidade do Solo',
                                                        style:
                                                        FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .title3,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 16.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Image(image: AssetImage('images/humSolo.png'), height: 52,),
                                                          Container(
                                                            width: 25,
                                                          ),
                                                          Text(
                                                            snapshot.data[index].humSolo.toString()
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
                                                          0.0, 8.0, 0.0, 8.0),
                                                      child: Text(
                                                        'Luminosidade',
                                                        style:
                                                        FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .title3,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 16.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Image(image: AssetImage('images/luz.png'), height: 52,),
                                                          Container(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            snapshot.data[index].luz.toString()
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
                                                          0.0, 8.0, 0.0, 8.0),
                                                      child: Text(
                                                        'Temperatura do Ar',
                                                        style:
                                                        FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .title3,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 16.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Image(image: AssetImage('images/temp.png'), height: 52,),
                                                          Container(
                                                            width: 15,
                                                          ),
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
                                            ],
                                          ),
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
