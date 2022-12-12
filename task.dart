import 'package:objectbox/objectbox.dart';
import 'package:list/models/group.dart';

class Task {
  int id = 0;
  String description;
  bool completed = false;

  final group = ToOne<Group>();

  Task({
    required this.description,
  });
}
