import 'package:flutter/material.dart';

const _border_radius = 20.0;

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {@required this.message,
      @required this.timestamp,
      @required this.isMine});

  final isMine;
  final message;
  final timestamp;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.all(10.0),
      child: Material(
        elevation: 5.0,
        color: isMine ? Colors.white : Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_border_radius),
          bottomRight: Radius.circular(_border_radius),
          topLeft:
              isMine ? Radius.circular(_border_radius) : Radius.circular(0.0),
          topRight:
              isMine ? Radius.circular(0.0) : Radius.circular(_border_radius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            message,
            style: TextStyle(
              color: isMine ? Theme.of(context).primaryColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
