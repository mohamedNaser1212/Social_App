import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/models/posts_model.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return ConditionalBuilder(
      condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).usermodel !=null  ,
      builder: (context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10,
              margin: const EdgeInsets.all(8),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  const Image(
                    image: NetworkImage(
                        'https://image.freepik.com/free-vector/abstract-dynamic-pattern-wallpaper-vector_53876-59179.jpg'),
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Communicate with friends',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 8,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildPostItem( SocialCubit.get(context).posts[index],context,index),
              itemCount: SocialCubit.get(context).posts.length,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ), fallback: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
    },
    );
  },
);
  }

  Widget buildPostItem(PostModel model,context,index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: const TextStyle(
                            height: 1.4,
                            fontSize: 20,
                            fontFamily: 'Jannah',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const    SizedBox(
                          width: 5,
                        ),
                        const    Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16,
                        )
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz_outlined,
                  size: 20,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 15),
            child: Container(
              width: double.infinity,
              color: Colors.grey[300],
              height: 0,
            ),
          ),
           Text(
            '${model.text}',
            style:const TextStyle(
              height: 1.2,
              fontSize: 16,
              fontFamily: 'Belleza',
              fontWeight: FontWeight.w600,
            ),
          ),

          // SizedBox(
          //   width: double.infinity,
          //   child: Wrap(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsetsDirectional.only(end: 1.0),
          //         child: SizedBox(
          //           height: 30,
          //           child: MaterialButton(
          //             onPressed: () {},
          //             height: 20,
          //             padding: EdgeInsets.zero,
          //             minWidth: 1,
          //             child: TextButton(
          //               onPressed: () {},
          //               child: Text(
          //                 '#software',
          //                 style: Theme.of(context)
          //                     .textTheme
          //                     .caption
          //                     ?.copyWith(
          //                     color: Colors.blue,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsetsDirectional.only(end: 1.0),
          //         child: Container(
          //           height: 30,
          //           child: MaterialButton(
          //             onPressed: () {},
          //             height: 25,
          //             padding: EdgeInsets.zero,
          //             minWidth: 1,
          //             child: TextButton(
          //               onPressed: () {},
          //               child: Text(
          //                 '#Flutter',
          //                 style: Theme.of(context)
          //                     .textTheme
          //                     .caption
          //                     ?.copyWith(
          //                     color: Colors.blue,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          if(model.postImage!='')
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 15.0),
            child: Container(
              padding: EdgeInsets.zero,
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:  DecorationImage(
                  image: NetworkImage(
                      '${model.postImage}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${SocialCubit.get(context).likes[index]} Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 30,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.chat_bubble_outline,
                              size: 20,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          //'${SocialCubit.get(context).comments[index]} Comments',
                          '0 Comments',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                         CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).usermodel!.image}'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Write a comment ...',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          onPressed: () {
                            SocialCubit.get(context).LikePosts(
                                SocialCubit.get(context).postsId[index],
                            );
                          },
                          icon: const Icon(
                            Icons.favorite_outline,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
