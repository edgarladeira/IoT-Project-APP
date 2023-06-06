import 'dart:convert';
import 'dart:core';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


import 'flutter_flow/flutter_flow_theme.dart';

import 'package:http/http.dart' as http;
import 'Record.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'secPag.dart';

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

  final List<int> entries = <int> [1];

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
        body: Container(
          child: ListView.builder(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
                  return Card(
                  color: FlutterFlowTheme.of(context).primaryColor,
                  child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>secPage()));
                      },
                      title: Text ('Arduino ${entries[index]}', style: TextStyle(color: Colors.white)),),
                  );},
      ),
    ),
    ),
    );
  }
}
