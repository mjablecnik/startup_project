import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/app/global.dart';
import 'package:flutter_project_template/core/i18n/translations.g.dart';
import 'package:flutter_project_template/core/app/cached_data.dart';
import 'package:flutter_project_template/view/layouts/default/default_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: context.t.about.title,
      body: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(),
          1: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              TableCell(
                child: Container(
                  height: 24,
                  width: 32,
                  color: Colors.white,
                  child: Text(
                    context.t.about.name,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  height: 24,
                  width: 32,
                  color: Colors.white,
                  child: Text(
                    context.get<CachedData>().appName,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: <Widget>[
              TableCell(
                child: Container(
                  height: 24,
                  width: 32,
                  color: Colors.white,
                  child: Text(
                    context.t.about.version,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  height: 24,
                  width: 32,
                  color: Colors.white,
                  child: Text(
                    context.get<CachedData>().appVersion,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
