
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_admin_app/application/screens/home/cubit/theme.dart';
import 'package:super_admin_app/application/screens/home/screen_home.dart';
import 'package:super_admin_app/application/screens/login/bloc/bloc/login_bloc.dart';
import 'package:super_admin_app/application/screens/login/screen_login.dart';
import 'package:super_admin_app/application/screens/subzone/bloc/bloc/subzone_bloc.dart';
import 'package:super_admin_app/application/screens/zone/bloc/bloc/zone_bloc.dart';
import 'package:super_admin_app/application/screens/supervisor/cubit/zonelist_cubit.dart';
import 'package:super_admin_app/data/shared_pref/shared_pref.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
   bool isLoggedIn = await SharedPreferenses.getBoolValue() ?? false;
  runApp( MyApp(isLoggined: isLoggedIn,));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggined});
  final bool isLoggined; 

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(),),
        BlocProvider(create: (context) => ThemeCubit(),),
        BlocProvider(create: (context) => ZoneBloc(),),
        BlocProvider(create: (context) => ZoneSelectionCubit(),), 
        BlocProvider(create: (context) => SubZoneBloc(),), 
      ], 
      child:  BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          home:isLoggined?const ScreenHome() : const ScreenLogIn(),
        );
      },
    )
    );
  }
}