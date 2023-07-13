
import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:bataman_gpt/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class chat_screen_layouts extends StatefulWidget {
  const chat_screen_layouts({super.key});

  @override
  State<chat_screen_layouts> createState() => _chat_screen_layoutsState();
}

class _chat_screen_layoutsState extends State<chat_screen_layouts> {
  final TextEditingController send_message_controller=TextEditingController();
  final List<chat_message> _messages =[];
  List<String> responseList = [];


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
    chat_message greeting = chat_message(
      text: "Welcome, Master Wayne. How can I assist you today?",
      sender: 'Alfred',
    );

    setState(() {
      _messages.insert(0, greeting);
    });

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
          child: SingleChildScrollView(
            child: TextField(
              maxLines: null,
              onSubmitted: (value) => send_message(),
              controller: send_message_controller,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Yes, Master Bruce',
                hintStyle: TextStyle(color: Colors.grey[800],),
                contentPadding: EdgeInsets.only(left: 8),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            // Add your desired action when the image button is tapped
            send_message();
          },
          child: Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/batwing2.png'),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle, // Use BoxShape.rectangle for a rectangular image button
            ),
          ),
        )

      ],
    );
  }
  void send_message(){
    chat_message new_messages=chat_message(text: send_message_controller.text, sender: 'Batman');
    setState(() {
      _messages.insert(0,new_messages);
    });
    send_message_controller.clear();

    /*
    final request = CompleteText(prompt: new_messages.text, model: TextDavinci3Model(), maxTokens: 150);
    This creates a CompleteText request with the prompt set to the
    new_messages.text, which is the user's input message. It also specifies the
    GPT-3 model to use (TextDavinci3Model()) and sets the maximum number of
    tokens for the response to 150.

    _subscription = batmanGPT!.build(token: 'YOUR_API_KEY').onCompletionSSE(request: request).listen((event) { ... });
    This code sets up a subscription to the OpenAI API using the provided API
    key (YOUR_API_KEY). It uses Server-Sent Events (SSE) to receive responses
    from the API. It listens for the completion events and executes the callback
    function when a response is received.

    String responseText = event.choices[0].text.toString();
    This extracts the text content of the first choice in the response and
    converts it to a string.

    responseList.add(responseText);
    This adds the responseText to the responseList that stores the individual
    responses received.

    if (event.choices[0].finishReason != null && event.choices[0].finishReason == 'stop') { ... }
    This checks if the finishReason of the first choice in the response is not
    null and equals 'stop'. This condition is used to determine if the response
    is complete and no further tokens are expected.

    String fullResponse = responseList.join('');
    This joins all the individual responses in the responseList into a single
    string, fullResponse, without any separator.

    chat_message ai_message = chat_message(text: fullResponse, sender: 'Alfred');
    This creates a chat_message object with the fullResponse as the text content
     and sets the sender as 'Alfred'.

    setState(() { _messages.insert(0, ai_message); });
    This updates the state of the widget by inserting the ai_message at the
    beginning of the _messages list. This triggers a rebuild of the UI to display
     the new message.

    responseList.clear();
    This clears the responseList to prepare for the next set of responses.
    Overall, this code subscribes to the OpenAI API for completion events,
    processes the received responses, and updates the UI with the combined
    response when the completion event indicates that the response is complete.
     */

    final request =CompleteText(prompt: new_messages.text, model:TextDavinci3Model(),maxTokens: 150,  );
    _subscription=batmanGPT!.build(token:'USE YOUR OWN API KEY (: ')
        .onCompletionSSE(request: request)
        .listen((event) {
      String responseText = event.choices[0].text.toString();
      responseList.add(responseText);

      if (event.choices[0].finishReason != null && event.choices[0].finishReason == 'stop') {
        String fullResponse = responseList.join('');
        if (fullResponse.trim().isNotEmpty) { // Check if the response is not empty
          chat_message ai_message = chat_message(text: fullResponse, sender: 'Alfred');
          setState(() {
            _messages.insert(0, ai_message);
          });
        }
        responseList.clear();
      }
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
        child: Container(
          decoration: BoxDecoration(
            image:DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/bg2.jpg')
            ),
          ),
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
                // margin: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                  child: _text_field(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
