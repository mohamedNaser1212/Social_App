import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_app/screens/home_screen.dart';
import 'package:social_app/screens/regester_screen.dart';

import '../cache_helper.dart';
import '../constant.dart';
import '../cubit/login_cubit.dart';
import '../custom_widgets/costum_text_field.dart';
import '../custom_widgets/custom_button.dart';
import '../reusable_widgets.dart';
import '../show_snack_bar.dart';
import '../states/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  String? globalEmail;
  String? globalPassword;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state)  {
          if (state is LoginSuccessState) {
            uId = state.uId;
             CacheHelper.saveData(key: 'uId', value: uId).then((value) {
               navigateAndFinish(
                 context: context,
                 screen: const HomeScreen(),
               );

             });

          } else if (state is LoginErrorState) {
            // showFlushBar(
            //   context: context,
            //   message: state.error,
            // );
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);

          return Scaffold(
            backgroundColor:Colors.grey[300],
            body: Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      const SizedBox(height: 50),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height ,
                        padding: const EdgeInsets.all(20),
                        decoration:const  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: SingleChildScrollView(

                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 150),
                                const Text(
                                  'Log in',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0D3961),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const  Text(
                                  'Your Email',
                                  style:  TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff7B8189),
                                  ),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    } else if (!value.contains('@')) {
                                      return 'Invalid email format';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    globalEmail = value;
                                  },
                                ),
                                const SizedBox(height: 20),
                                const   Text('Password'),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  obscureText: true,
                                  onFieldSubmitted: (value) {
                                    cubit.userLogin(
                                      email: globalEmail!,
                                      password: value,
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    globalPassword = value;
                                  },
                                ),
                                const SizedBox(height: 30),
                                Center(
                                  child: reusableElevatedButton(
                                    label: 'Login',
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                      email: globalEmail!,
                                      password: globalPassword!,
                                    );
                                  }
                                }
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Don\'t have an account?',
                                      style:  TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff124460),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    InkWell(
                                      onTap: () {
                                        navigateTo(
                                          context: context,
                                          screen: RegisterationScreen(),
                                        );
                                      },
                                      child:const Text(
                                        'Sign Up Now',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xff124460),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
