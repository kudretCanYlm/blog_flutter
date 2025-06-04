import 'package:blog_app/model/blog_model.dart';
import 'package:blog_app/view_model/blog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BlogDetailPage extends StatelessWidget {
  const BlogDetailPage({super.key, required this.titleName});

  final String titleName;

  @override
  Widget build(BuildContext context) {
    final blog_store = Provider.of<BlogViewModel>(context, listen: false);

    final blog = blog_store.getByName(titleName);

    return Scaffold(
      appBar: AppBar(title: Text(blog.title)),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: SizedBox(
              // height: 50,<--  Remove this
              child: Text(
                blog.description,
                // style: TheOnesTextStyle.paragraphBoldMedium(),
                maxLines: 150,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
