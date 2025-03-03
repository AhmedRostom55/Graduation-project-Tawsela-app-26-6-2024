// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) => UserRequest(
      phone_num: json['phone_num'] as String?,
      f_name: json['f_name'] as String?,
      l_name: json['l_name'] as String?,
      Req_ID: json['req_id'] as String?,
      Current_Location: json['current_location'] as String?,
      Desired_Location: json['desired_location'] as String?,
      Current_Location_Latitude: json['current_location_latitude'] as String?,
      Current_Location_Longitude: json['current_location_longitude'] as String?,
      Desired_Location_Latitude: json['desired_location_latitude'] as String?,
      Desired_Location_Longitude: json['desired_location_longitude'] as String?,
      is_reserved: json['is_reserved'] as String?,
    );

Map<String, dynamic> _$UserRequestToJson(UserRequest instance) =>
    <String, dynamic>{
      'Req_ID': instance.Req_ID,
      // 'f_name': instance.f_name,
      // 'l_name': instance.l_name,
      'Phone_Num': instance.phone_num,
      'Current_Location': instance.Current_Location,
      'Desired_Location': instance.Desired_Location,
      'Current_Location_Latitude': instance.Current_Location_Latitude,
      'Current_Location_Longitude': instance.Current_Location_Longitude,
      'Desired_Location_Latitude': instance.Desired_Location_Latitude,
      'Desired_Location_Longitude': instance.Desired_Location_Longitude,
      'is_reserved': instance.is_reserved,
    };
