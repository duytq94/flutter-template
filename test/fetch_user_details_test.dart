import 'package:flutter_template/repositories/user_repository.dart';
import 'package:flutter_template/services/services.dart';
import 'package:flutter_template/user_details/models/user_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'fetch_user_details_test.mocks.dart';

@GenerateMocks([BaseClient])
void main() {
  group('fetchUserDetails', () {
    test("test fetchUserDetails success", () async {
      final mockClient = MockBaseClient();

      when(mockClient.get("https://api.github.com/users/duytq94")).thenAnswer((realInvocation) async {
        Map<String, dynamic> response = {
          "login": "duytq94",
          "name": "Duy Tran",
          "location": "Viet Nam",
          "avatar_url": "https://avatars.githubusercontent.com/u/24253421?v=4"
        };
        return response;
      });

      final userRepository = UserRepository(baseClient: mockClient);
      expect(await userRepository.fetchUserDetails(), isA<UserDetails>());
    });
  });
}
