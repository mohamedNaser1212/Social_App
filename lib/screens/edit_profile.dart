

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/reusable_widgets.dart';

class EditProfile extends StatelessWidget {
   EditProfile({super.key});
var nameController=TextEditingController();
var bioController=TextEditingController();
var phoneController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var userModel=SocialCubit.get(context).usermodel;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).CoverImage;
        nameController.text=userModel!.name!;
        bioController.text=userModel.bio!;
        phoneController.text=userModel.phone!;
        return Scaffold(
          appBar: defaultappbar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                  text: 'Update',
                  function: () {
                    SocialCubit.get(context).UpdateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);


                  }
              ),
              const SizedBox(width: 15,),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)

                    const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                width: double.infinity,
                                height: 140,
                                decoration:  BoxDecoration(
                                  borderRadius:const BorderRadius.only(
                                      topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                                  image: DecorationImage(
                                    image:  coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius:64,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(onPressed: (){
                              SocialCubit.get(context).getProfileImage();

                            }, icon: const CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.camera_alt,
                                size: 20,
                              ),
                            ),)
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                 if(SocialCubit.get(context).profileImage!=null || SocialCubit.get(context).CoverImage!=null)
                  Row(
                    children: [
                      if(SocialCubit.get(context).CoverImage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            reusableElevatedButton(
                                label: 'Upload Cover',
                                function: (){
                                SocialCubit.get(context).uploadCoverImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                );
                                }
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              const SizedBox(height: 5,),
                            if(state is SocialUserUpdateLoadingState)

                              const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10,),
        if(SocialCubit.get(context).profileImage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            reusableElevatedButton(
                                label: 'Upload Profile',
                                function: (){
                                  SocialCubit.get(context).
                                  uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                }
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              SizedBox(height: 5,),
                            if(state is SocialUserUpdateLoadingState)

                              const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).profileImage!=null || SocialCubit.get(context).CoverImage!=null)

                    const SizedBox(height: 20,),
                  reusableTextFormField(
                    label: nameController.text,
                      prefix: const Icon(Icons.person),
                      validator: (value){
                      if(value!.isEmpty){
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      onTap: (){},
                      controller:nameController ,
                      keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 10,),

                  reusableTextFormField(
                    label: bioController.text,
                    prefix: const Icon(Icons.info_sharp),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    onTap: (){},
                    controller:bioController ,
                    keyboardType: TextInputType.text,
                  ),

                  reusableTextFormField(
                    label: phoneController.text,
                    prefix: const Icon(Icons.call),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    onTap: (){},
                    controller:phoneController ,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),

        );
      },
    );
  }
}
