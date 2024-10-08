import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/app/global.dart';
import 'package:flutter_project_template/core/i18n/translations.g.dart';
import 'package:flutter_project_template/logic/cubits/auth_cubit.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.t.menu.loggedUser),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    context.get<AuthCubit>().loggedUser?.fullName ?? "<unknown>",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Wrap(
                  spacing: 12,
                  children: [
                    Text(context.t.menu.role),
                    const Text(
                      "User",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(context.t.menu.settings),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(context.t.menu.about),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.about);
            },
          ),
          ListTile(
            title: Text(context.t.menu.logout),
            onTap: () {
              Navigator.pop(context);
              context.get<AuthCubit>().logout();
              Navigator.of(context).pushReplacementNamed(Routes.auth);
            },
          ),
        ],
      ),
    );
  }
}
