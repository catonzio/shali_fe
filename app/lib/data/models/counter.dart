import 'package:get/get.dart';

class Counter {
  final RxInt _value = 0.obs;

  int get value => _value.value;
  set value(int newValue) => _value.value = newValue;
}
