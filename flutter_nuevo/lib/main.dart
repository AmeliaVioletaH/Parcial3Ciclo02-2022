import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late List? data;

  Future<String> getData() async {
    var response = await http.get(
        //Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        Uri.parse("https://jsonplaceholder.typicode.com/photos"),
        headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(response.body);
    });
    //print(data[1]["title"]);

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    data = null;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 117, 202),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 157, 0, 141),
        foregroundColor: Colors.white,
        title: const Text("Parcial 3 API - 2513422017", style: TextStyle(fontSize: 20),),
        leading: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.white, size: 30,),
          onPressed: () {},
        ),
      ),
      body: ListView.builder(
        // ignore: unnecessary_null_comparison
        itemCount: data == null ? 0 : data!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: const Color.fromARGB(255, 175, 0, 88),
            shadowColor: null,
            child: Column(
              children: [
                Text(data![index]["title"], textAlign: TextAlign.center, 
                  style: const TextStyle(fontSize: 24, color: Colors.white, fontFamily: "Times New Roman"),),
                Image.network(data![index]["url"]),
              ], 
            )
            //child: Text(data![index]["title"]),
          );
        },
      ),
    );
  }
}
