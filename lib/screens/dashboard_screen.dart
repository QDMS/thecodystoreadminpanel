import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecodystoreadminpanel/consts/firebase.dart';
import 'package:thecodystoreadminpanel/consts/padding.dart';
import 'package:thecodystoreadminpanel/inner_screens/add_product.dart';
import 'package:thecodystoreadminpanel/responsive.dart';
import 'package:thecodystoreadminpanel/services/global_method.dart';
import 'package:thecodystoreadminpanel/services/utils.dart';
import 'package:thecodystoreadminpanel/widgets/buttons.dart';
import 'package:thecodystoreadminpanel/widgets/grid_products.dart';
import 'package:thecodystoreadminpanel/widgets/header.dart';
import 'package:thecodystoreadminpanel/widgets/loader.dart';
import 'package:thecodystoreadminpanel/widgets/orders_list.dart';
import 'package:thecodystoreadminpanel/widgets/text_widget.dart';

import '../controllers/MenuController.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    Color color = Utils(context).color;

    return SafeArea(
      child: SingleChildScrollView(
        controller: ScrollController(),
        padding: EdgeInsets.all(DefaultPadding.defaultPadding),
        child: Column(
          children: [
            Header(
              title: 'Dashboard',
              fct: () {
                context.read<MenuController>().controlDashboardMenu();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              text: 'Latest Product',
              color: color,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: DefaultPadding.defaultPadding,
              ),
              child: Row(
                children: [
                  ButtonsWidget(
                    onPressed: () {},
                    text: 'View All',
                    icon: Icons.list,
                    backgroundColor: Colors.grey,
                  ),
                  const Spacer(),
                  ButtonsWidget(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UploadProductForm()));
                    },
                    text: 'Add Product',
                    icon: Icons.add,
                    backgroundColor: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: DefaultPadding.defaultPadding,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Responsive(
                        mobile: ProductGrid(
                          crossAxisCount: size.width < 700 ? 2 : 4,
                          childAspectRatio:
                              size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                        ),
                        desktop: ProductGrid(
                          childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                        ),
                      ),
                      // MyProductsHome(),
                      SizedBox(height: DefaultPadding.defaultPadding),
                      // OrdersScreen(),
                    const OrdersList()
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
