import 'package:bloc/bloc.dart';
import 'package:blocer/realm/schema.dart';
import 'package:realm/realm.dart';

class ChatsCubit extends Cubit<List<Chat>> {
  late Realm realm;
  ChatsCubit() : super([]);
  init(){
    final config = Configuration.local([Chat.schema, Message.schema, Person.schema],schemaVersion: 2, isReadOnly: false );
    realm = Realm(config);
    load();
  }

  void load() {
    emit(realm.all<Chat>().toList());
  }

  upsert(Chat chat)  {
    realm.write(() {
      realm.add<Chat>(chat, update: true);
    });
    load();
  }

  delete(Chat chat)  {
    realm.write(() {
      realm.delete<Chat>(chat);
    });
    load();
  }
}