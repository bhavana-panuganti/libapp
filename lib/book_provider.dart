
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookProvider extends ChangeNotifier {
  List<QueryDocumentSnapshot> books = [];

  Future<void> fetchBooks() async{
    final snapshot = await FirebaseFirestore.instance.collection('books').get();

    books=snapshot.docs;
    notifyListeners();
  }

  void addBook(String title, String borrow, String due) async{
    await FirebaseFirestore.instance.collection('books').add(
      {
        'title': title,
        'borrowDate': borrow,
        'dueDate': due,
      },
    );

    notifyListeners(); 
  }

  Future<void> deleteBook(String docId) async {
   await FirebaseFirestore.instance.collection('books').doc(docId).delete();
   await fetchBooks();
  }
}
