import 'package:blog_app/model/blog_model.dart';
import 'package:blog_app/view_model/blog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class NewBlogPage extends StatefulWidget {
  const NewBlogPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewBlogPageState();
}

class _NewBlogPageState extends State<NewBlogPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _title = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    final blogViewModel = Provider.of<BlogViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Add New Blog")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                key: Key("name"),
                decoration: InputDecoration(
                  labelText: "Name",
                  hintTextDirection: TextDirection.ltr,
                  fillColor: Colors.transparent,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _name = newValue!;
                },
              ),

              TextFormField(
                key: Key("title"),
                decoration: InputDecoration(
                  labelText: "Title",
                  hintTextDirection: TextDirection.ltr,
                  fillColor: Colors.transparent,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _title = newValue!;
                },
              ),
              TextFormField(
                key: Key("description"),
                decoration: InputDecoration(
                  labelText: "Description",
                  hintTextDirection: TextDirection.ltr,
                  fillColor: Colors.transparent,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _description = newValue!;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          _formKey.currentState!.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Saving...')),
                          );
                          final newBlog = BlogModel(
                            description: _description,
                            source: SourceModel(name: _name),
                            title: _title,
                          );
                          blogViewModel.addBlog(newBlog);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
