import 'dart:convert';

class BlogModel {
  final SourceModel source;
  //final String author;
  final String description;
  final String title;
  // final String category;
  // final String urlToImage;

  BlogModel({
    required this.source,
    // required this.author,
    required this.description,
    required this.title,
    //  required this.category,
    //   required this.urlToImage,
  });

  factory BlogModel.fromJson(Map<String, dynamic> data) {
    return BlogModel(
      source: SourceModel.fromJson(data["source"]),
      //   author: data["author"],
      description: data["description"],
      title: data["title"],
      //category: data["category"],
      //  urlToImage: data["urlToImage"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "source": source.toJson(),
      // "author": author,
      "description": description,
      "title": title,
      //"category": category,
      // "urlToImage": urlToImage,
    };
  }

  static Map<String, dynamic> toMap(BlogModel model) {
    return {
      "source": model.source.toJson(),
      // "author": author,
      "description": model.description,
      "title": model.title,
      //"category": category,
      // "urlToImage": urlToImage,
    };
  }

  static String encode(List<BlogModel> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => BlogModel.toMap(music))
        .toList(),
  );
}

class SourceModel {
  // final String id;
  final String name;

  SourceModel({
    //required this.id,
    required this.name,
  });

  factory SourceModel.fromJson(dynamic source) {
    return SourceModel(
      //id: source["id"],
      name: source["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //"id": id,
      "name": name,
    };
  }
}
