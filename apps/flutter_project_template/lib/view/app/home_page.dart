import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/app/injector.dart';
import 'package:flutter_project_template/view/features/product_list/product_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const ProductListPage();
  }
}
