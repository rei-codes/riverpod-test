import 'package:flutter/material.dart';

import '../models/post.dart';

class DetailsPage extends StatelessWidget {
  final Post post;
  const DetailsPage(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details'), centerTitle: true),
      body: Center(
        child: Text(post.title),
      ),
    );
  }
}
