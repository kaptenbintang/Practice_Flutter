import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OutlineText extends StatelessWidget {
  Color? outlineColor;
  double size;
  final String text;
  TextOverflow overflow;

  OutlineText(
      {this.outlineColor = const Color.fromARGB(255, 10, 3, 0),
      this.size = 0,
      super.key,
      this.overflow = TextOverflow.ellipsis,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(fontFamily: 'Roboto'),
    );
  }
}

// <Widget>[
//                                             // Stroked text as border.
//                                             Text(
//                                               'Business',
//                                               style: TextStyle(
//                                                 fontSize: 50,
//                                                 foreground: Paint()
//                                                   ..style = PaintingStyle.stroke
//                                                   ..strokeWidth = 3
//                                                   ..color = Colors.black,
//                                               ),
//                                             ),
//                                             // Solid text as fill.
//                                             Text(
//                                               'Business',
//                                               style: TextStyle(
//                                                 fontSize: 50,
//                                                 color: Color(0xFF68EBDC),
//                                               ),
//                                             ),
//                                           ],
