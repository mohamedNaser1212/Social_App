import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_app/screens/Login_page.dart';
import 'package:social_app/screens/home_screen.dart';

import '../cache_helper.dart';
import '../constant.dart';
import '../cubit/register_cubit.dart';
import '../reusable_widgets.dart';
import '../show_snack_bar.dart';
import '../states/register_states.dart';

class RegisterationScreen extends StatefulWidget {
  RegisterationScreen({super.key});
  static String id = 'RegisterationScreen';

  @override
  State<RegisterationScreen> createState() => RegisterationScreenState();
}

class RegisterationScreenState extends State<RegisterationScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? phone;
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state)async {
          if (state is RegisterErrorState) {
            showSnackBar(context, state.error);
          } else if (state is RegisterSuccessState) {
            uId = state.uId;
            print('uId is ' + uId!);
            await CacheHelper.saveData(key: 'uId', value: uId);
          } else if (state is CreateUserSuccessState) {
            navigateAndFinish(
              screen: const HomeScreen(), context: context,
            );
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);

          return SafeArea(
            child: Scaffold(
              body: ModalProgressHUD(
                inAsyncCall: state is RegisterLoadingState,
                child:Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height ,
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  color: Color(0xff3E657B),

                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 50,),

                                      Text(
                                        'Sign Up',
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'User Name',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffffffff),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      TextFormField(
                                        style: const TextStyle(
                                          color: Color(0xffffffff),
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        controller: nameController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return  'Please enter a username';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Your Email',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Inter',
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      TextFormField(
                                        style: const TextStyle(
                                          color: Color(0xffffffff),
                                        ),
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xffFFFFFF),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return  'Please enter an email';
                                          } else if (!value.contains('@')) {
                                            return 'Invalid email';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Phone Number',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffffffff),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      IntlPhoneField(
                                        style: const TextStyle(
                                          color: Color(0xffffffff),
                                        ),
                                        decoration: const InputDecoration(

                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xffFFFFFF),
                                            ),
                                          ),
                                        ),
                                        initialCountryCode: 'EG',
                                        onChanged: (data) {

                                          phone = data.completeNumber ;



                                        },
                                      ),

                                      Text(
                                       'Password',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffffffff),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      TextFormField(
                                        style: const TextStyle(
                                          color: Color(0xffffffff),
                                        ),
                                        controller: passwordController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                        ),
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a password';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                         'Re-enter password',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffffffff),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      TextFormField(
                                        style: const TextStyle(
                                          color: Color(0xffffffff),
                                        ),
                                        controller: confirmPasswordController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xffFFFFFF),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                        ),
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return  'Please re-enter the password';
                                          } else if (value != passwordController.text) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                             'Already have an account?',
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                               'Login',
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Container(
                                          width:
                                          MediaQuery.of(context).size.width /
                                              2,
                                          height:
                                          MediaQuery.of(context).size.height /
                                              17,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: const Color(
                                                0xffFFFFFF), // Your specified color
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  cubit.userRegister(
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                    password:
                                                    passwordController.text,
                                                    phone: phone!,
                                                  );
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  7,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                color: const Color(0xffFFFFFF),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Sign Up',
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      color: Color(0xff5D6B7B),
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Icon(
                                                    Icons.arrow_forward,
                                                    color: Color(0xff5D6B7B),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
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

                ),

              ),

            );

        },
      ),
    );
  }
}
