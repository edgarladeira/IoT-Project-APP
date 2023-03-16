import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'arduinos_record.g.dart';

abstract class ArduinosRecord
    implements Built<ArduinosRecord, ArduinosRecordBuilder> {
  static Serializer<ArduinosRecord> get serializer =>
      _$arduinosRecordSerializer;

  double? get temperatura;

  double? get humidade;

  @BuiltValueField(wireName: 'data_ultima_atualizacao')
  DateTime? get dataUltimaAtualizacao;

  DocumentReference? get user;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ArduinosRecordBuilder builder) => builder
    ..temperatura = 0.0
    ..humidade = 0.0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Arduinos');

  static Stream<ArduinosRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ArduinosRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ArduinosRecord._();
  factory ArduinosRecord([void Function(ArduinosRecordBuilder) updates]) =
      _$ArduinosRecord;

  static ArduinosRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createArduinosRecordData({
  double? temperatura,
  double? humidade,
  DateTime? dataUltimaAtualizacao,
  DocumentReference? user,
}) {
  final firestoreData = serializers.toFirestore(
    ArduinosRecord.serializer,
    ArduinosRecord(
      (a) => a
        ..temperatura = temperatura
        ..humidade = humidade
        ..dataUltimaAtualizacao = dataUltimaAtualizacao
        ..user = user,
    ),
  );

  return firestoreData;
}
