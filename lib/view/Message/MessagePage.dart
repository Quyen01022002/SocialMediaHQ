import 'dart:async';
import 'dart:ffi';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/controller/MessageBoxController.dart';

import '../../model/MessageModel.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}
class Message {
  final int id; // Định danh người gửi
  final String text;
  final bool isMe; // Kiểm tra xem tin nhắn có phải của bạn không
  final String avatarUrl;
  Message({required this.id, required this.text, required this.isMe, required this.avatarUrl});
}
class _MessagePageState extends State<MessagePage> {
  final MessageBoxController messageBoxController = Get.put(MessageBoxController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: ChatScreen(),
      );
  }
}
class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final MessageBoxController messageBoxController = Get.put(MessageBoxController());
  final List<Message> messages = [];
  Stream<List<MessageModel>>? messageModelStream;
  Future<void> _mapMessageModelToMessage(List<MessageModel> up)async{
    if(up!=null){
      up!.forEach((element) {

        if (element.userId==messageBoxController.user_id.value)
          {
            Message message = Message(
                id: element.userId ?? 0,
                text: element.content ?? '',
                isMe: true,
                avatarUrl: messageBoxController.user!.avatarUrl!);
            messages.add(message);
          }
        else
          {
            Message message = Message(
                id: element.friendId ?? 0,
                text: element.content ?? '',
                isMe: false,
                avatarUrl: messageBoxController.friend!.avatarUrl!);
            messages.add(message);
          }

      });
    }
  }

  @override
  void initState() {
    super.initState();

    _startTimer();
  }
  late Timer _timer;
  late bool check = true;
  late int leng = 0;
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // Gọi hàm cần thiết ở đây
      messageBoxController.loadMessage(messageBoxController.friend_id.value, context);
      messageModelStream = messageBoxController.listMessageStream;
      // Cập nhật danh sách nhóm khi Stream thay đổi
      messageModelStream?.listen((List<MessageModel>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            messages.clear();
            _mapMessageModelToMessage(updatedGroups);


          });
        }
      });
      if (leng != messages.length){
        check = true;
      leng = messages.length;}
      _loadMessages();

    });
  }
  void _loadMessages() {
    // Simulate loading messages from a data source
    // You can replace this with your actual data loading logic
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.addAll(messages);
      });

      if (check == true){
        scrollToBottom(_scrollController);
        check = false;
      }
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(messageBoxController.friend!.avatarUrl.toString()),
            ),
            SizedBox(width: 8.0), // Khoảng trống giữa avatar và tiêu đề
            Text(messageBoxController.friend!.first_name.toString()+ " " + messageBoxController.friend!.last_name.toString()),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StreamBuilder<List<MessageModel>>(
              stream: messageModelStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //final messages = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return message.isMe
                            ? _buildSentMessage(message)
                            : _buildReceivedMessage(message);
                      },
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            _buildInputField(),
          ],
        ),
      ),

    );
  }
  Widget _buildSentMessage(Message message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(), // Dịch sang phải để căn lề bên phải
          _buildMessageContainer(message),
          CircleAvatar(
            backgroundImage: NetworkImage(message.avatarUrl.toString()),
          ),// Khoảng trống giữa tin nhắn và avatar
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(Message message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(message.avatarUrl.toString()),
          ),
          SizedBox(width: 8.0), // Khoảng trống giữa avatar và tin nhắn
          _buildMessageContainer(message),
        ],
      ),
    );
  }

  Widget _buildMessageContainer(Message message) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: message.isMe ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: message.isMe ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageBoxController.textControllerMess,
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    setState(() {
      _messages.add(Message(id: messageBoxController.user_id.value, text: messageBoxController.textControllerMess.text, isMe: true, avatarUrl: messageBoxController.user!.avatarUrl.toString()));
    });
    _loadMessages();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    messageBoxController.CreateMessage(context, messageBoxController.friend_id.value);
    check = true;
  }
  void scrollToBottom(ScrollController controller) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.jumpTo(controller.position.maxScrollExtent);
    });
  }
}