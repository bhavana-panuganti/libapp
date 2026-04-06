import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:libapp/books_page.dart';
import 'package:provider/provider.dart';
import 'book_provider.dart';

class AddBookPage extends StatefulWidget{
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() =>_AddBookPageState();
  }
  class _AddBookPageState extends State<AddBookPage>{
  final titleController = TextEditingController();
  final borrowController = TextEditingController();
  final returnController = TextEditingController();

  void addbook() async{
    final provider= Provider.of<BookProvider>(context,listen: false);
    provider.addBook(
      titleController.text.trim(),
    borrowController.text.trim(),
    returnController.text.trim(),
      );
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
  
   return Scaffold(
    backgroundColor: Color.fromRGBO(255, 232, 214, 1),
     appBar: AppBar(title: const Text('add book'),
     backgroundColor:Color.fromRGBO(203, 153, 126, 1) ,),
     body: Padding(
      padding: const EdgeInsetsGeometry.all(10),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                  hintText: 'book title',
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                   color:Colors.black , 
                    width: 2,
                   ),
                      borderRadius: BorderRadius.circular(12),
                     ),
                     focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                      color: Color.fromRGBO(203, 153, 126, 1), 
                       width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      ),

                ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller:borrowController,
            decoration: InputDecoration(
                  hintText: 'date borrowed',
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                   color:Colors.black , 
                    width: 2,
                   ),
                      borderRadius: BorderRadius.circular(12),
                     ),
                     focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                      color: Color.fromRGBO(203, 153, 126, 1), 
                       width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      ),

                ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: returnController,
            decoration: InputDecoration(
                  hintText: 'return date',
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                   color:Colors.black , 
                    width: 2,
                   ),
                      borderRadius: BorderRadius.circular(12),
                     ),
                     focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                      color: Color.fromRGBO(203, 153, 126, 1), 
                       width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      ),

                ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: addbook, child: const Text('SUBMIT',style: TextStyle(
            color: Colors.white
          ),))
        ],
      ),
      ),
   );
  }
 }
