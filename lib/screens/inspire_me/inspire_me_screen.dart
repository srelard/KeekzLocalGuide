import 'package:flutter/material.dart';
import 'package:keekz_local_guide/models/post_model.dart';
import 'package:keekz_local_guide/models/user_model.dart';
import 'package:keekz_local_guide/services/database_service.dart';
import 'package:keekz_local_guide/widgets/keekz_view.dart';

class InspireMeScreen extends StatefulWidget {
  static final String id = 'feed_screen';
  final String currentUserId;

  InspireMeScreen({this.currentUserId});

  @override
  _InspireMeScreenState createState() => _InspireMeScreenState();
}

class _InspireMeScreenState extends State<InspireMeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Instagram',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
            fontSize: 35.0,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: DatabaseService.getFeedPosts(widget.currentUserId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return SizedBox.shrink();
          }
          final List<Post> posts = snapshot.data;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              Post post = posts[index];
              return FutureBuilder(
                future: DatabaseService.getUserWithId(post.authorId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox.shrink();
                  }
                  User author = snapshot.data;
                  return PostView(
                    currentUserId: widget.currentUserId,
                    post: post,
                    author: author,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
