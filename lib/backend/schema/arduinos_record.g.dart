// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arduinos_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ArduinosRecord> _$arduinosRecordSerializer =
    new _$ArduinosRecordSerializer();

class _$ArduinosRecordSerializer
    implements StructuredSerializer<ArduinosRecord> {
  @override
  final Iterable<Type> types = const [ArduinosRecord, _$ArduinosRecord];
  @override
  final String wireName = 'ArduinosRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, ArduinosRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.temperatura;
    if (value != null) {
      result
        ..add('temperatura')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.humidade;
    if (value != null) {
      result
        ..add('humidade')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.dataUltimaAtualizacao;
    if (value != null) {
      result
        ..add('data_ultima_atualizacao')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  ArduinosRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ArduinosRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'temperatura':
          result.temperatura = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'humidade':
          result.humidade = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'data_ultima_atualizacao':
          result.dataUltimaAtualizacao = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$ArduinosRecord extends ArduinosRecord {
  @override
  final double? temperatura;
  @override
  final double? humidade;
  @override
  final DateTime? dataUltimaAtualizacao;
  @override
  final DocumentReference<Object?>? user;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$ArduinosRecord([void Function(ArduinosRecordBuilder)? updates]) =>
      (new ArduinosRecordBuilder()..update(updates))._build();

  _$ArduinosRecord._(
      {this.temperatura,
      this.humidade,
      this.dataUltimaAtualizacao,
      this.user,
      this.ffRef})
      : super._();

  @override
  ArduinosRecord rebuild(void Function(ArduinosRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ArduinosRecordBuilder toBuilder() =>
      new ArduinosRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArduinosRecord &&
        temperatura == other.temperatura &&
        humidade == other.humidade &&
        dataUltimaAtualizacao == other.dataUltimaAtualizacao &&
        user == other.user &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, temperatura.hashCode), humidade.hashCode),
                dataUltimaAtualizacao.hashCode),
            user.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ArduinosRecord')
          ..add('temperatura', temperatura)
          ..add('humidade', humidade)
          ..add('dataUltimaAtualizacao', dataUltimaAtualizacao)
          ..add('user', user)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class ArduinosRecordBuilder
    implements Builder<ArduinosRecord, ArduinosRecordBuilder> {
  _$ArduinosRecord? _$v;

  double? _temperatura;
  double? get temperatura => _$this._temperatura;
  set temperatura(double? temperatura) => _$this._temperatura = temperatura;

  double? _humidade;
  double? get humidade => _$this._humidade;
  set humidade(double? humidade) => _$this._humidade = humidade;

  DateTime? _dataUltimaAtualizacao;
  DateTime? get dataUltimaAtualizacao => _$this._dataUltimaAtualizacao;
  set dataUltimaAtualizacao(DateTime? dataUltimaAtualizacao) =>
      _$this._dataUltimaAtualizacao = dataUltimaAtualizacao;

  DocumentReference<Object?>? _user;
  DocumentReference<Object?>? get user => _$this._user;
  set user(DocumentReference<Object?>? user) => _$this._user = user;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  ArduinosRecordBuilder() {
    ArduinosRecord._initializeBuilder(this);
  }

  ArduinosRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _temperatura = $v.temperatura;
      _humidade = $v.humidade;
      _dataUltimaAtualizacao = $v.dataUltimaAtualizacao;
      _user = $v.user;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ArduinosRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ArduinosRecord;
  }

  @override
  void update(void Function(ArduinosRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ArduinosRecord build() => _build();

  _$ArduinosRecord _build() {
    final _$result = _$v ??
        new _$ArduinosRecord._(
            temperatura: temperatura,
            humidade: humidade,
            dataUltimaAtualizacao: dataUltimaAtualizacao,
            user: user,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
