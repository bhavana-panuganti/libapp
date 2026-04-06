import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libapp/widgets/task_card.dart';
import 'books_page.dart';
import 'map_page.dart';
import 'seat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String,dynamic>> items=[
    {"title":"Seat Map","page":MapPage()},
    {'title':'My Seat',"page":SeatPage()},
    {'title':"Books Page","page":BooksPage()},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 232, 214, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(203, 153, 126, 1),
        title: const Text('Home Page',style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),
      ),
      toolbarHeight: 70,
      ),
      floatingActionButton: FloatingActionButton(
  backgroundColor: Color.fromRGBO(203, 153, 126, 1),
  onPressed: () async {
    await FirebaseAuth.instance.signOut();
  },
  child: const Icon(Icons.logout)
),
      body: Center(
        child: Column(
          children: [
            Expanded(
            child: ListView.separated(
             itemCount: items.length,

             itemBuilder: (context, index) {
             return GestureDetector(
             onTap: () {
             Navigator.push(
             context,
             MaterialPageRoute(
              builder: (context) => items[index]['page'],
              ),
             );
              },
              child: TaskCard(
               color: Color.fromRGBO(203, 153, 126, 1),
                headerText: items[index]["title"],
               ),
               );
               },

               separatorBuilder: (context, index) 
               {
                  return const SizedBox(height: 12); 
          },
          ),
          )
          ],
        ),
      ),
      
    );
  }
}