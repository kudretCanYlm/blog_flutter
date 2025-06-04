import 'package:blog_app/view_model/blog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final blog_store = Provider.of<BlogViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Main Page")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              //TODO
              context.goNamed("new_blog");
            },
            child: Text("Add new Blog"),
          ),
          Expanded(
            child: Consumer<BlogViewModel>(
              builder: (_, blogViewModel, _) {
                if (blogViewModel.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: blogViewModel.blogs.length,
                  itemBuilder: (_, index) {
                    final blog = blogViewModel.blogs[index];
                    return Row(
                      children: [
                        Card(
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () => {
                              context.goNamed(
                                "blog_detail",
                                pathParameters: {'title': blog.title},
                              ),
                            },
                            child: ListTile(
                              leading: const Icon(Icons.group),
                              title: Text(
                                blog.title,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            blog_store.deleteByTitle(blog.title);
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
