import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'to_do_list_record.g.dart';

abstract class ToDoListRecord
    implements Built<ToDoListRecord, ToDoListRecordBuilder> {
  static Serializer<ToDoListRecord> get serializer =>
      _$toDoListRecordSerializer;

  double? get temperatura;

  double? get humidade;

  @BuiltValueField(wireName: 'data_ultima_atualizacao')
  DateTime? get dataUltimaAtualizacao;

  String? get user;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ToDoListRecordBuilder builder) => builder
    ..temperatura = 0.0
    ..humidade = 0.0
    ..user = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ToDoList');

  static Stream<ToDoListRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ToDoListRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ToDoListRecord._();
  factory ToDoListRecord([void Function(ToDoListRecordBuilder) updates]) =
      _$ToDoListRecord;

  static ToDoListRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createToDoListRecordData({
  double? temperatura,
  double? humidade,
  DateTime? dataUltimaAtualizacao,
  String? user,
}) {
  final firestoreData = serializers.toFirestore(
    ToDoListRecord.serializer,
    ToDoListRecord(
      (t) => t
        ..temperatura = temperatura
        ..humidade = humidade
        ..dataUltimaAtualizacao = dataUltimaAtualizacao
        ..user = user,
    ),
  );

  return firestoreData;
}
