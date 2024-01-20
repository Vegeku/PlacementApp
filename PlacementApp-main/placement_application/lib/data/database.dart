import 'package:hive_flutter/hive_flutter.dart';

class RoleDatabase {
  List jobs = [];

  final _myBox = Hive.box('roles');

  void loadData() {
    jobs = _myBox.get("ROLES");
  }

  void updateDatabase() {
    _myBox.put('ROLES', jobs);
  }
}
