import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libapp/add_book_page.dart';
import 'package:libapp/book_provider.dart';
import 'package:libapp/widgets/book_card.dart';
import 'package:provider/provider.dart';
import 'book_provider.dart';
class BooksPage extends StatefulWidget{
   BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {

  @override
  void initState() {
    super.initState();
   
   Provider.of<BookProvider>(context,listen: false).fetchBooks();
  }
 

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<BookProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(203, 153, 126, 1),
        title: Text('Books page')
      ),
      backgroundColor: Color.fromRGBO(255, 232, 214, 1),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: provider.books.length,
                itemBuilder: (context,index){
                  final book=provider.books[index];
                  final data=book.data() as Map<String,dynamic>;

                  return BookCard(
                    BName: data['title'], 
                    date: data['borrowDate'], 
                    retDate: data['dueDate'], 
                    bookId: book.id
                  );
                }
                ),
            ),
          ],
        ),
      ),
    floatingActionButton: FloatingActionButton(
  backgroundColor: Color.fromRGBO(203, 153, 126, 1),
  child: const Icon(Icons.add, color: Colors.black),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddBookPage()),
    );
  },
),
    );
  }
}