import 'package:hive/hive.dart';
part 'user_hive.g.dart';

@HiveType(typeId: 0)
class UserHive extends HiveObject {
  UserHive(
      {required this.username, required this.email, required this.password});
  @HiveField(0)
  String username;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  @HiveField(3)
  String? address;

  @HiveField(4)
  String? imgUrl;
}
