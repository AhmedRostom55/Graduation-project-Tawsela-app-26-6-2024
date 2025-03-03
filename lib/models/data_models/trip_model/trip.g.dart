// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
      TripID: json['TripID'] as String,
      Req_ID: json['Req_ID'] as String?,
      Phone_Num: json['Phone_Num'] as String?,
      Start_Time: json['Start_Time'] as String?,
      End_Time: json['End_Time'] as String?,
      Trip_Status: json['Trip_Status'] as String?,
      Price: json['Price'] as String?,
      Trip_type: json['Trip_type'] as String?,
      Current_Location: json['Current_Location'] as String?,
      Desired_Location: json['Desired_Location'] as String?,
      Current_Location_Latitude: json['Current_Location_Latitude'] as String?,
      Current_Location_Longitude: json['Current_Location_Longitude'] as String?,
      Desired_Location_Latitude: json['Desired_Location_Latitude'] as String?,
      Desired_Location_Longitude: json['Desired_Location_Longitude'] as String?,
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'TripID': instance.TripID,
      'Phone_Num': instance.Phone_Num,
      'Req_ID': instance.Req_ID,
      'Start_Time': instance.Start_Time,
      'End_Time': instance.End_Time,
      'Trip_Status': instance.Trip_Status,
      'Price': instance.Price,
      'Trip_type': instance.Trip_type,
      'Current_Location': instance.Current_Location,
      'Desired_Location': instance.Desired_Location,
      'Current_Location_Latitude': instance.Current_Location_Latitude,
      'Current_Location_Longitude': instance.Current_Location_Longitude,
      'Desired_Location_Latitude': instance.Desired_Location_Latitude,
      'Desired_Location_Longitude': instance.Desired_Location_Longitude,
    };
