import 'package:blocer/bloc/cubit/auth.dart';
import 'package:blocer/bloc/cubit/chats_cubit.dart';
import 'package:blocer/helper/date_time_foemater.dart';
import 'package:blocer/helper/utils.dart';
import 'package:blocer/pages/chat/chat_page.dart';
import 'package:blocer/realm/schema.dart';
import 'package:faker/faker.dart' as Faker;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final Faker.Faker faker = Faker.Faker();
    return BlocProvider(
      create: (_)=>ChatsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Blocer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),
          centerTitle: false,
          actions: [
            BlocBuilder<ChatsCubit, List<Chat>>(builder: (_, state){
              return Text(state.length.toString());
            }),
            PopupMenuButton(
                itemBuilder: (context){
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("My Account"),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text("Logout"),
                    ),
                  ];
                },
                onSelected:(value){
                  if(value == 0){
                    debugPrint("My account menu is selected.");
                  }else if(value == 1){
                    debugPrint("Settings menu is selected.");
                  }else if(value == 2){
                    Utility.showLoadingDialog(context);
                    Future.delayed(const Duration(seconds: 3)).then((value){
                      Navigator.of(context).pop();
                      (context.read<AuthCubit>().logout());
                    });
                  }
                }
            )
          ],
        ),
        body: BlocBuilder<ChatsCubit, List<Chat>>(
            builder: (_, chats) {
              return ListView.separated(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  bool isOutGoing = faker.randomGenerator.boolean();
                  bool isRead = faker.randomGenerator.boolean();
                  Chat chat = chats[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (
                          context) => const ChatPage()));
                    },
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 2.5, horizontal: 15),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: Image
                          .network("https://i.pravatar.cc/80?id=$index")
                          .image,
                    ),
                    title: Text(chat.persons.firstWhere((element) => element.phone !="919123881186").name, style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(fontWeightDelta: 2),),
                    subtitle: Text("text",
                      overflow: TextOverflow.ellipsis,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall!
                          .apply(
                          color: isRead ? Theme
                              .of(context)
                              .colorScheme
                              .primary : Theme
                              .of(context)
                              .textTheme
                              .bodySmall!
                              .color!
                              .withOpacity(0.8)
                      ),
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(DateTimeFormatter.timeAgo(DateTime.now().subtract(
                            Duration(minutes: index)))),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 1,
                    margin: const EdgeInsets.only(left: 80, right: 15),
                    color: Colors.grey.withOpacity(0.2),
                  );
                },
              );
            }
        ),
        floatingActionButton: BlocBuilder<ChatsCubit, List<Chat>>(
            builder: (context, chats) {
              context.read<ChatsCubit>().init();
              return FloatingActionButton(
                onPressed: (){
                  Person person = Person(ObjectId(), faker.person.name(), faker.phoneNumber.toString());
                  context.read<ChatsCubit>().realm.write((){
                    context.read<ChatsCubit>().realm.add<Person>(person);
                  });
                  context.read<ChatsCubit>().upsert(Chat(ObjectId(), persons: [person]));
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              );
            }),
        drawer: const NavigationDrawer(
          children: [
            NavigationDrawerDestination(icon: Icon(Icons.group), label: Text("Messages")),
            NavigationDrawerDestination(icon: Icon(Icons.settings), label: Text("Settings"))
          ],
        ),
      ),
    );
  }
}

