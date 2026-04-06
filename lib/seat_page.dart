import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SeatPage extends StatefulWidget{
  const SeatPage({super.key});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  
  
@override
Widget build(BuildContext context) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('seats')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots(),
      
    builder: (context, snapshot) {

      bool isOccupied = false; 
      int? seatNumber;

      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
        final seat = snapshot.data!.docs.first;
        final data = seat.data() ;
        print(data);
        isOccupied = data['isOccupied'];
        seatNumber = data['seatNumber'];
      }
print("Seat assigned to: ${FirebaseAuth.instance.currentUser!.uid}");
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Seat'),
          backgroundColor: Color.fromRGBO(203, 153, 126, 1),
        ),
        backgroundColor: Color.fromRGBO(255, 232, 214, 1),
        body: Column(
          children: [

            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: isOccupied ?  Color.fromRGBO(203, 153, 126, 1) : Color.fromRGBO(221, 190, 169, 1), // 🔥 key change
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    isOccupied ? "Seat Occupied" : "Seat Free",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    isOccupied
                        ? "Seat $seatNumber"
                        : "No seat assigned",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: isOccupied
                          ? () async {
                              final seat = snapshot.data!.docs.first;
                              await FirebaseFirestore.instance
                                  .collection('seats')
                                  .doc(seat.id)
                                  .update({
                                'isOccupied': false,
                                'userId': "",
                              });
                            }
                          : null,
                      child: const Text("Leave Seat",style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
}