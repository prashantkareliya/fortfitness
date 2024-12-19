import 'package:hive/hive.dart';
part 'profile_data.g.dart';

@HiveType(typeId: 0)
class ProfileModel{

  @HiveField(0)
  String? userEmail;

  @HiveField(1)
  String? accessToken;

  @HiveField(2)
  String? userId;

  @HiveField(3)
  String? userImage;

  ProfileModel(this.userEmail, this.accessToken, this.userId, this.userImage);

}