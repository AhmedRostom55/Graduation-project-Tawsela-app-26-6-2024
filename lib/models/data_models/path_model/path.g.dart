// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Distance _$DistanceFromJson(Map<String, dynamic> json) => Distance(
      json['text'] as String?,
      (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DistanceToJson(Distance instance) => <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
    };

Duration_t _$Duration_tFromJson(Map<String, dynamic> json) => Duration_t(
      json['text'] as String?,
      (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$Duration_tToJson(Duration_t instance) =>
    <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
    };

Path_t _$Path_tFromJson(Map<String, dynamic> json) => Path_t(
      Distance.fromJson(json['distance'] as Map<String, dynamic>),
      Duration_t.fromJson(json['duration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Path_tToJson(Path_t instance) => <String, dynamic>{
      'distance': instance.distance.toJson(),
      'duration': instance.duration.toJson(),
    };
