import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/const.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State <ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{

  final openAI = OpenAI.instance.build(token: OPENAI_API_KEY, 
                                      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)), enableLog: true);


  final ChatUser currentUser = ChatUser(id: '1', firstName: 'User');
  final ChatUser gptChatUser = ChatUser(id: '2', firstName: 'ChatGPT');
  List <ChatMessage> messages = <ChatMessage>[];
  
  @override
  Widget build(BuildContext context){
      return Scaffold(appBar: AppBar(
        title: Text('AI Chat Assistant'),
        backgroundColor: Colors.green[300],
        ),
        body: DashChat(
          currentUser: currentUser,
          messageOptions: const MessageOptions(
            currentUserContainerColor: Colors.lightBlue,
            containerColor: Colors.green,
            textColor: Colors.white,
          ),
          onSend: (ChatMessage m){
          getChatResponse(m);
        }, messages: messages)
      );
  }

  Future <void> getChatResponse(ChatMessage m) async {
      setState(() {
        messages.insert(0, m);
      });
      List<Messages> messagesHistory = messages.reversed.map((m) {
        if(m.user == currentUser){
          return Messages(content: m.text, role: Role.user);
        } else {
          return Messages(content: m.text, role: Role.assistant);
        }
      }).toList();
      
      final request = ChatCompleteText(
        messages: messagesHistory.map((msg) => msg.toJson()).toList(),
        maxToken: 500,
        model: Gpt4oMini2024ChatModel(),
      );

      final response = await openAI.onChatCompletion(request: request);
      for(var element in response!.choices){
        if(element.message != null){
          setState(() {
            messages.insert(0, ChatMessage(user: gptChatUser, 
                                          createdAt: DateTime.now(), 
                                          text: element.message!.content),
                                          );
          });
        }

      }
  }
}