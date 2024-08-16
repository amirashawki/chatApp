import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frist_project/constant.dart';
import 'package:frist_project/model/message.dart';
import 'package:frist_project/widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
   ChatPage({super.key});
  static String id = 'ChatPage';

  FirebaseFirestore firestore = FirebaseFirestore.instance;
   CollectionReference messages = FirebaseFirestore.instance.collection('messages');
   
 TextEditingController controller=TextEditingController();
 final controllerScroll=ScrollController();
  @override
  Widget build(BuildContext context) {
    var email= ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>( 
      stream: messages.orderBy('KCreateAt',descending: true).snapshots(),
      
     builder:(context,snapshot){
       if(snapshot.hasData){
        List<Message>messageList=[];
        for(int i=0;i<=snapshot.data!.docs.length;i++){
          messageList.add(Message.fromJson(snapshot.data!.docs[i]));
        }
        return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              KLogo,
              height: 50,
            ),
            Text(
              'Chat',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messageList.length,
              itemBuilder: (Context, index) {
              return messageList[index].id ==email? ChatBubble(message: messageList[index],)
              :ChatBubbleForFriend(message: messageList[index]);
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
            onSubmitted:(data) {
              messages.add(
                {'message ': data,
                 'id':email,
                 KCreateAt:DateTime.now(),      
                        }
              );
              controller.clear();
              controllerScroll.animateTo(
               0,
               duration: Duration(seconds: 10),
                curve: Curves.easeIn);
              
            },
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.send),
                suffixIconColor: kPrimaryColor,
                hintText: 'Send a Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          )
        ],
      ),
    );
     }
     else{
      return Text('is loading ...');
     }
       }


     
      
     );
  }
}
