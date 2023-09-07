import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/models/user_model.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});
static String id='chats_screen';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return ConditionalBuilder(


      condition: SocialCubit.get(context) .users.isNotEmpty,
      builder: (BuildContext context) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildchatItem(SocialCubit.get(context).users[index]),
          separatorBuilder: (context, index) => const Divider(
            thickness: 1,
          ),
          itemCount:SocialCubit.get(context) .users.length,);
      },
      fallback: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },

    );
  },
);

  }
  Widget buildchatItem(UserModel model) => InkWell(
    onTap: () {},
    child:  Padding(
      padding:const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                '${model.image}'),
          ),
          const  SizedBox(
            width: 20,
          ),
          Text(
            '${model.name}',
            style:const TextStyle(
              height: 1.4,
              fontSize: 20,
              fontFamily: 'Jannah',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
