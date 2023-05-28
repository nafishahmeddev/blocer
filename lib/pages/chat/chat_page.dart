import 'package:blocer/helper/date_time_foemater.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatPage extends StatefulWidget{
  const ChatPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage>{
  final Faker faker = Faker();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  String _name = "";
  DateTime _lastSeen = DateTime.now();
  List<Map<String, dynamic>> _messages = [];
  String _message = "";

  @override
  void initState() {
    setState(() {
      _messages = List.generate(20, (index) => {
        "message": faker.lorem.sentence(),
        "dateTime": faker.date.dateTime(minYear: 2022, maxYear: 2023),
        "isFirstParty": faker.randomGenerator.boolean()
      });
      _name = faker.person.name();
      _lastSeen = faker.date.dateTime(minYear: 2022, maxYear: 2023);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: Image.network("https://i.pravatar.cc/80").image,
            ),
            const SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_name, style: Theme.of(context).textTheme.bodyMedium!.apply(fontWeightDelta: 2, fontSizeDelta: 2)),
                Text("last seen ${DateTimeFormatter.timeAgo(_lastSeen)}", style: Theme.of(context).textTheme.bodySmall,),
              ],
            )
          ],
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (context){
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("Clear Chat"),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Delete Chat"),
                  ),
                ];
              },
              onSelected:(value){
                if(value == 0){
                  debugPrint("My account menu is selected.");
                }else if(value == 1){
                  debugPrint("Settings menu is selected.");
                }
              }
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Stack(
                children: [
                  SvgPicture.network("https://blog.1a23.com/wp-content/uploads/sites/2/2020/02/pattern-6.svg", fit: BoxFit.cover, width: double.infinity, color: Colors.grey.withOpacity(0.1),),
                  ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (context, index){

                      Map<String, dynamic> obj = _messages.reversed.toList()[index];
                      bool isFirstParty = obj["isFirstParty"] ?? false;
                      return Container(
                        alignment: isFirstParty? Alignment.topLeft : Alignment.topRight,
                        child:Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.7
                              ),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(15),
                                    topRight: const Radius.circular(15),
                                    bottomLeft:  Radius.circular(isFirstParty? 0: 15),
                                    bottomRight: Radius.circular(isFirstParty? 15: 0),
                                  ),
                                  color: isFirstParty ? Colors.grey.withOpacity(0.1): Theme.of(context).colorScheme.inversePrimary.withOpacity(0.2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(obj["message"], style: Theme.of(context).textTheme.bodyMedium,),
                                      const SizedBox(height: 3,),
                                      Text(DateTimeFormatter.timeAgo(DateTime.now().subtract(Duration(minutes: index))), style: Theme.of(context).textTheme.bodySmall!.apply(color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.4)),)
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ),
                      );
                    }
                ),
      ]
              )
          ),
          Container(
            color: Colors.grey.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.face)),
                Expanded(
                    child: Form(
                      child: TextFormField(
                        controller: _messageController,
                        onChanged: (String message){
                          setState(() {
                            _message = message;
                          });
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Message"
                        ),
                      ),
                    )
                ),
                Visibility(visible: _messageController.text.isNotEmpty,child: IconButton(onPressed: (){
                  setState(() {
                    _messages.add({
                      "message": _messageController.text,
                      "dateTime": DateTime.now(),
                      "isFirstParty": faker.randomGenerator.boolean()
                    });
                  });
                  _messageController.clear();
                  _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
                }, icon: const Icon(Icons.send)),),
                Visibility(visible: _messageController.text.isEmpty,child: IconButton(onPressed: (){}, icon: const Icon(Icons.attach_file)),),
                Visibility(visible: _messageController.text.isEmpty,child: IconButton(onPressed: (){}, icon: const Icon(Icons.mic)),),
              ],
            ),
          )
        ],
      ),
    );
  }

}