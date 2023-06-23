import 'package:contact_list/models/user_return.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserAndContactsRepo {
  Future<void> createUser(UserReturnModel userObj) async {
    await Future.delayed(const Duration(seconds: 1), () async {
      final saved = ParseObject('user')
        ..set('username', userObj.username)
        ..set('email', userObj.email)
        ..set('password', userObj.password)
        ..set('address', userObj.address);
      await saved.save();
    });
  }

  Future<List<ParseObject>> getUser() async {
    QueryBuilder<ParseObject> queryUser =
        QueryBuilder<ParseObject>(ParseObject('user'));
    final ParseResponse apiResponse = await queryUser.query();
    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }
}
