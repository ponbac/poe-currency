import 'package:poe_currency/models/user.dart';
import 'package:poe_currency/repositories/user_repository.dart';
import "package:test/test.dart";

void main() {
  var userRepository = UserRepository();

  String username = 'pontus';
  String password = 'password';

  test('Test login auth.', () async {
    String token = await userRepository.authenticate(
        username: username, password: password);
    //print(token);

    expect(token.length, greaterThan(15));
  });

  test('Test persist token.', () async {
    await userRepository.deleteToken();
    bool tokenBefore = await userRepository.hasToken();
    expect(tokenBefore, isFalse);

    String token = await userRepository.authenticate(
        username: username, password: password);
    await userRepository.persistToken(token);
    bool tokenAfter = await userRepository.hasToken();
    expect(tokenAfter, isTrue);
  });

  test('Test delete token.', () async {
    String token = await userRepository.authenticate(
        username: username, password: password);
    await userRepository.persistToken(token);
    await userRepository.deleteToken();

    bool tokenAfter = await userRepository.hasToken();
    expect(tokenAfter, isFalse);
  });

  test('Test fetching current user.', () async {
    String token = await userRepository.authenticate(
        username: username, password: password);
    await userRepository.persistToken(token);
    
    User user = await userRepository.fetchCurrentUser();
    //print(user);

    expect(user.username, equals(username));
  });

  test('Test register user.', () async {
    User user = await userRepository.register(
        username: 'testing', password: 'test123', accountname: 'brabra', poesessid: 'brasdaon2d');

    print(user);

    expect(user, isNotNull);
  });
}
