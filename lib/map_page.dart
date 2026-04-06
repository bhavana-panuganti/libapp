import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seat Map"),
        backgroundColor:  Color.fromRGBO(203, 153, 126, 1),
      ),
      backgroundColor: Color.fromRGBO(255, 232, 214, 1),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('seats').snapshots(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final seats = snapshot.data!.docs;

          return GridView.builder(
            itemCount: seats.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),

            itemBuilder: (context, index) {
             final seat = seats[index];
              final data = seat.data() as Map<String, dynamic>;

             return GestureDetector(
             onTap: () async {
              if (data['isOccupied'] == true) {
              ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Seat already occupied")),
             );
             return;
             }

             await FirebaseFirestore.instance
             .collection('seats')
              .doc(seat.id)
              .update({
              'isOccupied': true,
              'userId': FirebaseAuth.instance.currentUser!.uid,
             });

             print("Tapped seat ${data['seatNumber']}"); 
             },

              child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
              color: data['isOccupied'] ? Color.fromRGBO(221, 190, 169, 1) : Color.fromRGBO(203, 153, 126, 1),
              borderRadius: BorderRadius.circular(12),
              ),
               child: Center(
               child: Text("Seat ${data['seatNumber']}"),
               ),
               ),
              );
            }
          );
        },
      ),
    );
  }
}