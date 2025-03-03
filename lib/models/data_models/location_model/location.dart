import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

@JsonSerializable(explicitToJson: true)
class Location_t {
  double latitude;
  double longitude;
  Location_t(this.latitude, this.longitude);
  Map<String, dynamic> toJson() {
    return _$Location_tToJson(this);
  }

  factory Location_t.FromJson(Map<String, dynamic> json) {
    return _$Location_tFromJson(json);
  }
}