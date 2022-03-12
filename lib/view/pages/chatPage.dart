import 'package:animate_do/animate_do.dart';
import 'package:chatapp/widgets/chat_page_widgets.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final List data;
  const ChatPage({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              splashColor: Colors.transparent,
              child: CircleAvatar(
                backgroundImage: NetworkImage(data[2]),
                radius: 24.0,
              ),
              onTap: () {},
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(data[0].toString()),
          ],
        ),
      ),
      body: FadeInUp(
        child: ChatPageWidget(
          indexAt: data[0],
          path: data[1],
        ),
      ),
    );
  }
}
