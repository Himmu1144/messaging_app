import 'package:flutter/material.dart';
import 'package:mimiko/services/auth/auth_service.dart';
import 'package:mimiko/components/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() async {
    // get the auth service
    final authService = AuthService();

    // sign out
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Icon(
                Icons.book_rounded,
                color: Theme.of(context).colorScheme.inversePrimary,
              )),

              DrawerTile(
                  title: 'Home',
                  leading: Icon(
                    Icons.book_rounded,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              // Notes tile
              DrawerTile(
                  title: 'Settings',
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings');
                  }),
            ],
          ),

          // Notes tile

          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: DrawerTile(
                title: 'Logout',
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                onTap: logout),
          ),

          // Settings Tile
        ],
      ),
    );
  }
}
