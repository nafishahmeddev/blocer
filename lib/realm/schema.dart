import 'package:realm/realm.dart';
part 'schema.g.dart';
@RealmModel()
class _Person{
  @PrimaryKey()
  late ObjectId id;
  late String name;
  late String phone;
}

@RealmModel()
class _Message{
  @PrimaryKey()
  late ObjectId id;
  late _Person? person;
  late String message;
  late DateTime dateTime;
  late _Chat? chat;
}

@RealmModel()
class _Chat{
  @PrimaryKey()
  late ObjectId id;
  late List<_Person> persons;
  late _Message? lastMessage;
}

