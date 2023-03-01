import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)

class UserModel {

  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  @HiveField(2)
  String? id;

  UserModel({required this.email, required this.password}) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}