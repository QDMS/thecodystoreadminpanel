import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thecodystoreadminpanel/consts/padding.dart';
import 'package:thecodystoreadminpanel/widgets/loader.dart';
import 'package:thecodystoreadminpanel/widgets/orders_widget.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('orders').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Loader(),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data!.docs.isNotEmpty) {
            return Container(
              padding: EdgeInsets.all(DefaultPadding.defaultPadding),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        OrdersWidget(
                          imageUrl: snapshot.data!.docs[index]['imageUrl'],
                          totalPrice: snapshot.data!.docs[index]['totalPrice'],
                          price: snapshot.data!.docs[index]['price'],
                          productId: snapshot.data!.docs[index]['productId'],
                          userId: snapshot.data!.docs[index]['userId'],
                          quantity: snapshot.data!.docs[index]['quantity'],
                          orderDate: snapshot.data!.docs[index]['orderDate'],
                          username: snapshot.data!.docs[index]['username'],
                          // phoneNumber: snapshot.data!.docs[index]
                          //     ['phoneNumber'],
                        ),
                        const Divider(
                          thickness: 3,
                        ),
                      ],
                    );
                  }),
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Text('Your store is empty'),
              ),
            );
          }
        }
        return const Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        );
      },
    );
  }
}
