import 'package:json_annotation/json_annotation.dart';
part 'path.g.dart';

abstract class DistanceDuartion {
  String? text;
  double? value;
  DistanceDuartion(this.text, this.value);
}

@JsonSerializable()
class Distance extends DistanceDuartion {
  Distance(super.text, super.value);
  factory Distance.fromJson(Map<String, dynamic> json) {
    return _$DistanceFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$DistanceToJson(this);
  }
}

@JsonSerializable()
class Duration_t extends DistanceDuartion {
  Duration_t(super.text, super.value);
  factory Duration_t.fromJson(Map<String, dynamic> json) {
    return _$Duration_tFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$Duration_tToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class Path_t {
  Distance distance;
  Duration_t duration;
  Path_t(this.distance, this.duration);
  factory Path_t.fromJson(Map<String, dynamic> json) {
    return _$Path_tFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$Path_tToJson(this);
  }

  Path_t.invalid()
      : distance = Distance('', -1),
        duration = Duration_t('', -1);
}