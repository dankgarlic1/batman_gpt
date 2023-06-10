import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:bataman_gpt/chat_message.dart';
import 'package:flutter/material.dart';
class chat_screen_layouts extends StatefulWidget {
  const chat_screen_layouts({super.key});

  @override
  State<chat_screen_layouts> createState() => _chat_screen_layoutsState();
}

class _chat_screen_layoutsState extends State<chat_screen_layouts> {
  final TextEditingController send_message_controller=TextEditingController();
  final List<chat_message> _messages =[];

  OpenAI? batmanGPT;
/*
The line StreamSubscription? _subscription; declares a nullable variable
_subscription of type StreamSubscription from the dart:async library.
In Dart, a StreamSubscription is used to listen to events from a stream. It
represents a subscription to a stream and allows you to control the subscription,
such as canceling it when it's no longer needed.
By declaring _subscription as nullable (?), it means that the variable can hold
either an instance of the StreamSubscription class or null.
In the provided code, _subscription is used to store the subscription to a stream.
 */
  StreamSubscription? _subscription;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    batmanGPT= OpenAI.instance;
    /*
    The initState() method is called when the stateful widget is inserted into
    the widget tree for the first time.
    It is used to initialize the state of the widget, such as initializing
    variables or setting up subscriptions.
    In this case, batmanGPT is assigned an instance of the OpenAI class
    (presumably from the chat_gpt_sdk package) using the OpenAI.instance
    singleton getter. This initializes the batmanGPT variable with the instance
    of the OpenAI class.
     */
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _subscription?.cancel();
    super.dispose();
    /*
    The dispose() method is called when the stateful widget is removed from the
    widget tree.
    It is used to clean up resources and perform any necessary cleanup operations.
    In this case, _subscription?.cancel() is called to cancel the stream
    subscription stored in the _subscription variable. The ?. is used for
    null-safe navigation to ensure that the cancel() method is only called if
    _subscription is not null.
    Finally, super.dispose() is called to invoke the base class's dispose()
    method and properly dispose of the state.
     */
  }




  Widget _text_field(){
    return Row(
      children: [
        Expanded(
            child: TextField(
              onSubmitted: (value) => send_message(),
              controller: send_message_controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Yes, Master Bruce',
                contentPadding: EdgeInsets.only(left: 8),
              ),
            ),
        ),
        IconButton(
            onPressed: () =>  send_message(),
            icon: Icon(Icons.send_outlined),
        ),
      ],
    );
  }
  void send_message(){
    chat_message new_messages=chat_message(text: send_message_controller.text, sender: 'Batman');
    setState(() {
      _messages.insert(0,new_messages);
    });
    send_message_controller.clear();

    final request =CompleteText(prompt: new_messages.text, model:kChatGptTurboModel,maxTokens: 150,  );
    _subscription=batmanGPT!.build(token:'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')
        .onCompletionStream(request: request)
        .listen((event) {
          chat_message ai_message = chat_message(text: event!.choices[0].text, sender:'Alfred');
          
          setState(() {
            _messages.insert(0,ai_message);
          });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Batman GPT"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                child:ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return  _messages[index];
                  },
                ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: _text_field(),
            ),
          ],
        ),
      ),
    );
  }
}
