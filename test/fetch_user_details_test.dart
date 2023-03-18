import 'package:flutter_template/repositories/user_details_repository.dart';
import 'package:flutter_template/services/services.dart';
import 'package:flutter_template/ui/user_details/models/user_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'fetch_user_details_test.mocks.dart';

@GenerateMocks([BaseClient])
void main() {
  group('fetchUserDetails', () {
    test("test fetchUserDetails success", () async {
      final mockClient = MockBaseClient();
      when(mockClient.get("users/duytq94")).thenAnswer((_) async {
        Map<String, dynamic> json = {
          "login": "duytq94",
          "name": "Duy Tran",
          "location": "Viet Nam",
          "avatar_url": "https://avatars.githubusercontent.com/u/24253421?v=4"
        };
        var res = UserDetails.fromJson(json);
        return Success<UserDetails>(res);
      });

      final userRepository = UserDetailsRepositoryImpl(mockClient);
      expect(await userRepository.getUserDetails(), isA<Result>());
    });
  });
}
