import 'package:json_annotation/json_annotation.dart';
part 'request_model.g.dart';

@JsonSerializable()
class UserRequest {
  final String? Req_ID;
  final String? f_name;
  final String? l_name;
  final String? phone_num;
  final String? Current_Location;
  final String? Desired_Location;
  final String? Current_Location_Latitude;
  final String? Current_Location_Longitude;
  final String? Desired_Location_Latitude;
  final String? Desired_Location_Longitude;
  final String? is_reserved;
  const UserRequest({
    this.phone_num,
    this.f_name,
    this.l_name,
    required this.Req_ID,
    required this.Current_Location,
    required this.Desired_Location,
    required this.Current_Location_Latitude,
    required this.Current_Location_Longitude,
    required this.Desired_Location_Latitude,
    required this.Desired_Location_Longitude,
    required this.is_reserved,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) {
    return _$UserRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserRequestToJson(this);
  }
}