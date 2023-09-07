import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/app_cubit.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/screens/Login_page.dart';
import 'package:social_app/screens/home_screen.dart';



import 'cache_helper.dart';

import 'cubit/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final String? uId = await CacheHelper.getData(key: 'uId');
  Widget startPage;
 // Replace HomeScreen with the actual screen you want to show when the user is logged in
if(uId!=null){
  startPage=HomeScreen();
}else{
  startPage=LoginScreen();

}
  runApp(MyApp(startPage: startPage));
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.startPage,
  }) : super(key: key);

  final Widget startPage;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return   MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()..getAllUsers(),
        ),


      ],
      child: MaterialApp(
        //  themeMode: ThemeMode.dark,
        // darkTheme: ThemeData.dark(),


        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme:  const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.white,
            elevation: 2,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            elevation: 20,
          ),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),),

        home: widget.startPage,
        ),
    );
  }
}
