import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';

import '../reusable_widgets.dart';
import 'edit_profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
static String id='settings_screen';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var userModel=SocialCubit.get(context).usermodel;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 190,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    padding: EdgeInsets.zero,
                    width: double.infinity,
                    height: 140,
                    decoration:  BoxDecoration(
                      borderRadius:const BorderRadius.only(
                          topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                      image: DecorationImage(
                        image: NetworkImage(
                            '${userModel?.cover}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                 CircleAvatar(
                  radius:64,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        '${userModel?.image}'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
           Text('${userModel?.name}',style:const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
          const SizedBox(height: 5,),
           Text('${userModel?.bio}',style:TextStyle(
            color: Colors.black12.withOpacity(0.6),
            fontSize: 16,
          )),

           Padding(
             padding: const EdgeInsets.symmetric(vertical: 30.0),
             child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        const Text('100',style:TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                         Text('posts',style:TextStyle(
                          color: Colors.black12.withOpacity(0.6),
                          fontSize: 16,
                        )),

                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        const Text('256',style:TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                        Text('Photos',style:TextStyle(
                          color: Colors.black12.withOpacity(0.6),
                          fontSize: 16,
                        )),

                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        const Text('10k',style:TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                        Text('Followers',style:TextStyle(
                          color: Colors.black12.withOpacity(0.6),
                          fontSize: 16,
                        )),

                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        const Text('64',style:TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                        Text('Friends',style:TextStyle(
                          color: Colors.black12.withOpacity(0.6),
                          fontSize: 16,
                        )),

                      ],
                    ),
                  ),
                ),
              ],
          ),
           ),

          Row(
            children: [
              Expanded(
                child:OutlinedButton(
                  style: OutlinedButton.styleFrom(

                    shape:const  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  onPressed: (){},
                  child: const Text('Add Photos',style: TextStyle(
                 //   color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),),
                ),
              ),
              const SizedBox(width: 10,),
              OutlinedButton(
                style: OutlinedButton.styleFrom(

                  shape:const  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                onPressed: (){

                  navigateTo(context: context, screen: EditProfile());
                },
                child: const Icon(
                  Icons.edit,
                 // color: Colors.blue,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  },
);
  }
}
