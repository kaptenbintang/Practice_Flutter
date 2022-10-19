import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color color1 = Colors.red;
  Color color2 = Colors.amber;
  late Color targetColor;
  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Latihan Draggable"),
        ),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Draggable<Color>(
                data: color1,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Material(
                    color: color1,
                    shape: StadiumBorder(), //melengkukang border
                    elevation: 3, //efekbayangan
                  ),
                ),
                childWhenDragging: SizedBox(
                  width: 50,
                  height: 50,
                  child: Material(
                    color: Colors.grey,
                    shape: StadiumBorder(), //melengkukang border
                    elevation: 0, //efekbayangan
                  ),
                ), //widget yang akan muncul setelah di drag menjadi abuabu
                feedback: SizedBox(
                  width: 50,
                  height: 50,
                  child: Material(
                    color: color1.withOpacity(0.7),
                    shape: StadiumBorder(), //melengkukang border
                    elevation: 3, //efekbayangan
                  ),
                ), //bentuk lingkaran ketika di drag
              ),
              Draggable<Color>(
                data: color2,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Material(
                    color: color2,
                    shape: StadiumBorder(), //melengkukang border
                    elevation: 3, //efekbayangan
                  ),
                ),
                childWhenDragging: SizedBox(
                  width: 50,
                  height: 50,
                  child: Material(
                    color: Colors.grey,
                    shape: StadiumBorder(), //melengkukang border
                    elevation: 0, //efekbayangan
                  ),
                ), //widget yang akan muncul setelah di drag menjadi abuabu
                feedback: SizedBox(
                  width: 50,
                  height: 50,
                  child: Material(
                    color: color2.withOpacity(0.7),
                    shape: StadiumBorder(), //melengkukang border
                    elevation: 3, //efekbayangan
                  ),
                ), //bentuk lingkaran ketika di drag
              )
            ],
          ),
          DragTarget<Color>(
            onWillAccept: (value) =>
                true, //fungsi apakah data yang dibawa mau diterima atau tidak
            onAccept: (value) {
              isAccepted = true;
              targetColor = value;
            }, //fungsi yang akan dilakukan ketika kita terima data tersebut
            builder: ((context, candidateData, rejectedData) {
              return (isAccepted)
                  ? SizedBox(
                      width: 100,
                      height: 100,
                      child: Material(
                        color: targetColor,
                        shape: StadiumBorder(), //melengkukang border
                        elevation: 3, //efekbayangan
                      ),
                    )
                  : SizedBox(
                      width: 100,
                      height: 100,
                      child: Material(
                        color: Colors.black26,
                        shape: StadiumBorder(), //melengkukang border
                      ),
                    );
            }),
          )
        ]),
      ),
    );
  }
}
