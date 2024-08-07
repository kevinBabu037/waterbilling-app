import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_admin_app/application/screens/agent/screen_agent.dart';
import 'package:super_admin_app/application/screens/home/cubit/theme.dart';
import 'package:super_admin_app/application/screens/login/screen_login.dart';
import 'package:super_admin_app/application/screens/subzone/screen_zonelist.dart';
import 'package:super_admin_app/application/screens/supervisor/screen_supervisor.dart';
import 'package:super_admin_app/application/screens/user/screen_user.dart';
import 'package:super_admin_app/application/screens/zone/zone.dart';
import 'package:super_admin_app/application/utils/colors.dart';
import 'package:super_admin_app/application/utils/routs.dart';
import 'package:super_admin_app/application/utils/snakbar_sowdiolag.dart';
import 'package:super_admin_app/data/shared_pref/shared_pref.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  LeftDrawerState createState() => LeftDrawerState();
}

class LeftDrawerState extends State<ScreenHome> {
  int _selectedIndex = 0; 

  final List<Widget> _pages = const [ 
    ScreenZone(),
    ScreenzonesList(),
    ScreenSupervisor(),
    ScreenAgent(),
    ScreenUser()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    }); 
    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tenant DashBord'),
        actions: [
         BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return IconButton(
              icon: Icon(theme.brightness == Brightness.dark 
                  ? Icons.light_mode 
                  : Icons.dark_mode),
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            );
      },
    )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: kClrBlue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( 
                    'Tenant DashBoard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text('Zone'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.location_city_outlined), 
              title: const Text('SubZone'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.supervisor_account),
              title: const Text('Supervisor'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Agent'),
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('User'), 
              onTap: () => _onItemTapped(4),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'), 
              onTap: (){
              kShowDialog(
              context: context, 
              title: "Log Out?", 
              contentTxt: "Are your sure want to Logout", 
              actionBtn1Txt: "Cancel", 
              actionBtn2Txt: "Logout", 
              onPressed: ()async {
                
                 await SharedPreferenses.deleteBool().
              then((_){
              kNavigationPushRemoveUntil(context,const ScreenLogIn());
             });
              },
              );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}
