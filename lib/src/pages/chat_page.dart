import 'dart:io';

import 'package:chat_app/src/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  List<ChatMessage> messages = [
  ];
  bool _writing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          spacing: 3,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text('Te', style: TextStyle(fontSize: 12))
            ),
            Text('Name user', style: TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => messages[index],
                itemCount: messages.length,
              )
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              height: 100,
              child: _inputChat(),
            )
          ],
        ),
      )
   );
  }

  Widget _inputChat(){
    void handleSubmit(String text){
      if(text.isEmpty) return;

      final newMessage = ChatMessage(
        text: text, 
        uid: '123', 
        animationController: AnimationController(
          vsync: this, 
          duration: Duration(milliseconds: 400)
        ));
      messages.insert(0, newMessage);
      newMessage.animationController.forward();
      setState(() {
        _writing = false;
      });

      _textController.clear();
      _focusNode.requestFocus();
    }

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: handleSubmit,
                onChanged: (value) {
                  setState(() {
                    if(value.trim().isNotEmpty){
                      _writing = true;
                    } else {
                      _writing = false;
                    }
                  });
                },
                focusNode: _focusNode,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send message', 
                ),
              )
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: 
              !Platform.isIOS 
                ? CupertinoButton(
                  onPressed: _writing
                    ? () => handleSubmit(_textController.text.trim())
                    : null,
                  child: Text('Send'), 
                )
                : Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: _writing
                        ? () => handleSubmit(_textController.text.trim())
                        : null, 
                      icon: Icon(Icons.send)
                    ),
                  ),
                )
            )
          ]
        ),
      )
    );
  }

  //Liberación de recursos
  @override
  void dispose() {
    for(var message in messages){
      message.animationController.dispose();
    }
    super.dispose();
  }
}