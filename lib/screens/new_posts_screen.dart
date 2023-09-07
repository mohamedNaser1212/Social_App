import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';

import '../cubit/app_cubit.dart';
import '../reusable_widgets.dart';

class NewPostsScreen extends StatelessWidget {
   NewPostsScreen({super.key});
var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: defaultappbar(
              context: context,
              title: 'Create Post',
              actions: [defaultTextButton(text: 'Post', function: () {
                if (SocialCubit
                    .get(context)
                    .PostImage == null) {
                  SocialCubit
                      .get(context)
                      .CreatePost(
                      text: textController.text,
                      dateTime: DateTime.now().toString());
                }else{
                  SocialCubit
                      .get(context)
                      .UploadPostImage(
                      text:textController.text ,
                      dateTime: DateTime.now().toString(),
                  );
                }
              }
    )
    ],
    ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(
                    color: Colors.blue,
                    backgroundColor: Colors.grey[300],
                    minHeight: 10,
                    value: 0.5,
                  ),
                if (state is SocialCreatePostLoadingState)

                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?size=626&ext=jpg&uid=R115080048&ga=GA1.1.1773467981.1690355899&semt=sph'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        'Nasser',
                        style: TextStyle(
                          height: 1.4,
                          fontSize: 20,
                          fontFamily: 'Jannah',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                 Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                if (SocialCubit.get(context).PostImage != null)

                  if(SocialCubit.get(context).PostImage!=null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image:FileImage(SocialCubit.get(context).PostImage!),
                                fit: BoxFit.fill,
                              )),
                        ),
                        IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: const CircleAvatar(
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Add Photo'),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('#tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
