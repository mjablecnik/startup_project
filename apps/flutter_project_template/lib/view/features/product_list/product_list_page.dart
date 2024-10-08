import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/app/cached_data.dart';
import 'package:flutter_project_template/core/app/global.dart';
import 'package:flutter_project_template/view/layouts/default/default_layout.dart';

import 'product_list.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: context.get<CachedData>().appName,
      body: const ProductList(),
    );
  }
}
