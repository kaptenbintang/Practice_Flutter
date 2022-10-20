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
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Latihan Text Field")),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.adb), //menambahkan icon di luar border
                    fillColor: Color.fromARGB(255, 184, 214, 228),
                    filled: true,
                    //prefix didepan text, suffix dibelakang text
                    suffix: Container(
                      width: 5,
                      height: 5,
                      color: Colors.red,
                    ), //bisa tambah widget apa aja tapi gaboleh ada suffix text begitu jg dengan prefix
                    prefixIcon: Icon(Icons.person), //icon didalam input
                    prefixText: "Name: ", // menambahkan text di dalam border
                    prefixStyle: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                    labelText: "Nama Lengkap",
                    // labelStyle: TextStyle(
                    //     color: Colors.blue, fontWeight: FontWeight.w600),
                    hintText: "Nama lengkapnya lho ...",
                    hintStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            10))), // input border melengkung
                // maxLength: 5, //maximal kata
                // maxLines: 3, //maximal berapa baris
                // obscureText: true, //buat password
                onChanged: (value) {
                  setState(() {});
                },
                controller: controller,
              ),
              Text(controller.text)
            ],
          ),
        ),
      ),
    );
  }
}
