// now performing the test on the api based working

import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

// making the class of the Mocktail
class MocktailWorking extends Mock implements http.Client {}

// making the body of the testing work

void main() {
  // group('User API Class testing', () {
  //   late MocktailWorking mockObj;
  //   // ignore: unused_local_variable
  //   late UserService userObj;

  //   setUp(() {
  //     mockObj = MocktailWorking();
  //     userObj = UserService(client: mockObj);
  //   });

  //   // Test 1
  //   test('when fetch user is run, the status code should be 200 with okay message', () async {
  //     // using the concept of mocktail
  //     when(() => mockObj.get(any())).thenAnswer((_) async {
  //       return http.Response(
  //         '[{"id": 1, "name": "Ali", "username": "ali", "email": "ali@x.com"}]',
  //         200,
  //       );
  //     });
  //     final result = await userObj.fetchUsers();
  //     expect(result, isA<List<User>>());
  //   });
  // });
}
