import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  final Stream<QuerySnapshot> products =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: products,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something Went Wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    final data = snapshot.requireData;
                    List<Product> demoproduct = [];

                    for (int i = 0; i < data.size; i++) {
                      demoproduct.add(Product(
                        id: data.docs[i]["pid"].toString(),
                        title: data.docs[i]["title"],
                        description: data.docs[i]["description"],
                        image: data.docs[i]["imageUrl"].toList(),
                        price: data.docs[i]["price"],
                      ));
                      print("object");
                      print(demoproduct[i]);
                    }

                    // print(demoproduct[0].price);

                    return Row(
                      children: [
                        // Text(data.docs[1]["title"]),
                        // // Text(data.docs[0]["description"]),
                        // // Text((data.docs[0]["price"]).toString()),
                        // Text(data.docs[0]["title"]),
                        // //Image(image: AssetImage(data.docs[1]["imageUrl"]))
                        //Image.network(snapshot.data!.docs[0]['imageUrl']),
                        ...List.generate(
                          demoproduct.length,
                          (index) {
                            print('asasasasas    ${index}');
                            // if (demoProducts[index].isPopular)
                            return ProductCard(product: demoproduct[index]);

                            // return SizedBox
                            //     .shrink(); // here by default width and height is 0
                          },
                        ),
                      ],
                    );
                  }),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
