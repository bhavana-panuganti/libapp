import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:libapp/book_provider.dart';
import 'package:provider/provider.dart';
class BookCard extends StatelessWidget{
  final String BName;
  final String date;
  final String retDate;
  final String bookId;

  const BookCard({
    super.key,
    required this.BName,
    required this.date,
    required this.retDate,
    required this.bookId,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
     margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
     padding: EdgeInsets.all(30),
     decoration: BoxDecoration(
      color:Color.fromRGBO(203, 153, 126, 1),
      borderRadius: BorderRadius.circular(15),
     ),
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(BName, style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
             ),
            ),
        Text("borrowed on :"+date, style:const TextStyle(
          fontSize: 15,
          fontWeight:FontWeight.bold
        ) ,
        ),
        Text("return by :"+retDate, style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold
        ),
        ),
        const SizedBox(height: 10,),
          ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
      ),
      onPressed: () {
        Provider.of<BookProvider>(context,listen: false).deleteBook(bookId);
      },
      child: const Text("Submit",style: TextStyle(
        color: Colors.white
      ),),
      ),
    
      ],
     ),
    );
  }
}