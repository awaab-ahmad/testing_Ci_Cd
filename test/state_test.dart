import 'package:flutter_test/flutter_test.dart';
import 'package:test_2/controller/state_manage.dart';

void main() {
  // making the unit testing

  group('State Class tests', () {
    late StateManage object;
    setUpAll(() {
      object = StateManage();
    });

    test(
      'When obj created, its value to be instantiated with name = Awaab Ahmad',
      () {
        // now making the act and assert
        final name = object.name;
        expect(name, 'Awaab Ahmad');
      },
    );

    test('When obj created, its value to be instantiated with age = 10', () {
      // now making the act and assert
      final age = object.age;
      expect(age, 10);
    });

    test(
      'When the function is called, the new elements should be assigned to it',
      () {
        late String name;
        object.addListener(() => name = object.name);
        object.changeValue('Asfar Ahmad', 20);
        expect(name, 'Asfar Ahmad');
      },
    );

    // making the testing function of async thing
    test('when async func is called, it will wait for one minute then will make the change name', () async {
      int count = 0;
      late String name;
      object.addListener(() {
        count++;
        name = object.name;
      });
      await object.changeAsyncName('Awaab Ahmad');
      expect(count, 1);
      expect(name, 'Awaab Ahmad');
    });
  });
}
