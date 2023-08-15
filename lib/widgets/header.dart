// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:thecodystoreadminpanel/consts/padding.dart';
import 'package:thecodystoreadminpanel/responsive.dart';
import 'package:thecodystoreadminpanel/services/utils.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.title,
    required this.fct,
    this.showTextField = true,
  }) : super(key: key);
  final String title;
  final Function fct;
  final bool showTextField;
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = Utils(context).color;

    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              fct();
            },
          ),
        if (Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        if (Responsive.isDesktop(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        !showTextField
            ? Container()
            : Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    fillColor: Theme.of(context).cardColor,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(
                            DefaultPadding.defaultPadding * 0.75),
                        margin: EdgeInsets.symmetric(
                            horizontal: DefaultPadding.defaultPadding / 2),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(
                            186,
                            12,
                            47,
                            1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Icon(
                          Icons.search,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
