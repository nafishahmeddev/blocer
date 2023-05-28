// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Person extends _Person with RealmEntity, RealmObjectBase, RealmObject {
  Person(
    ObjectId id,
    String name,
    String phone,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'phone', phone);
  }

  Person._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get phone => RealmObjectBase.get<String>(this, 'phone') as String;
  @override
  set phone(String value) => RealmObjectBase.set(this, 'phone', value);

  @override
  Stream<RealmObjectChanges<Person>> get changes =>
      RealmObjectBase.getChanges<Person>(this);

  @override
  Person freeze() => RealmObjectBase.freezeObject<Person>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Person._);
    return const SchemaObject(ObjectType.realmObject, Person, 'Person', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('phone', RealmPropertyType.string),
    ]);
  }
}

class Message extends _Message with RealmEntity, RealmObjectBase, RealmObject {
  Message(
    ObjectId id,
    String message,
    DateTime dateTime, {
    Person? person,
    Chat? chat,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'person', person);
    RealmObjectBase.set(this, 'message', message);
    RealmObjectBase.set(this, 'dateTime', dateTime);
    RealmObjectBase.set(this, 'chat', chat);
  }

  Message._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  Person? get person => RealmObjectBase.get<Person>(this, 'person') as Person?;
  @override
  set person(covariant Person? value) =>
      RealmObjectBase.set(this, 'person', value);

  @override
  String get message => RealmObjectBase.get<String>(this, 'message') as String;
  @override
  set message(String value) => RealmObjectBase.set(this, 'message', value);

  @override
  DateTime get dateTime =>
      RealmObjectBase.get<DateTime>(this, 'dateTime') as DateTime;
  @override
  set dateTime(DateTime value) => RealmObjectBase.set(this, 'dateTime', value);

  @override
  Chat? get chat => RealmObjectBase.get<Chat>(this, 'chat') as Chat?;
  @override
  set chat(covariant Chat? value) => RealmObjectBase.set(this, 'chat', value);

  @override
  Stream<RealmObjectChanges<Message>> get changes =>
      RealmObjectBase.getChanges<Message>(this);

  @override
  Message freeze() => RealmObjectBase.freezeObject<Message>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Message._);
    return const SchemaObject(ObjectType.realmObject, Message, 'Message', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('person', RealmPropertyType.object,
          optional: true, linkTarget: 'Person'),
      SchemaProperty('message', RealmPropertyType.string),
      SchemaProperty('dateTime', RealmPropertyType.timestamp),
      SchemaProperty('chat', RealmPropertyType.object,
          optional: true, linkTarget: 'Chat'),
    ]);
  }
}

class Chat extends _Chat with RealmEntity, RealmObjectBase, RealmObject {
  Chat(
    ObjectId id, {
    Message? lastMessage,
    Iterable<Person> persons = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'lastMessage', lastMessage);
    RealmObjectBase.set<RealmList<Person>>(
        this, 'persons', RealmList<Person>(persons));
  }

  Chat._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  RealmList<Person> get persons =>
      RealmObjectBase.get<Person>(this, 'persons') as RealmList<Person>;
  @override
  set persons(covariant RealmList<Person> value) =>
      throw RealmUnsupportedSetError();

  @override
  Message? get lastMessage =>
      RealmObjectBase.get<Message>(this, 'lastMessage') as Message?;
  @override
  set lastMessage(covariant Message? value) =>
      RealmObjectBase.set(this, 'lastMessage', value);

  @override
  Stream<RealmObjectChanges<Chat>> get changes =>
      RealmObjectBase.getChanges<Chat>(this);

  @override
  Chat freeze() => RealmObjectBase.freezeObject<Chat>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Chat._);
    return const SchemaObject(ObjectType.realmObject, Chat, 'Chat', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('persons', RealmPropertyType.object,
          linkTarget: 'Person', collectionType: RealmCollectionType.list),
      SchemaProperty('lastMessage', RealmPropertyType.object,
          optional: true, linkTarget: 'Message'),
    ]);
  }
}
