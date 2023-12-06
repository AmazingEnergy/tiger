class ApiSearchResult {
  List<RecipeModel>? recipes;
  List<RestaurantModel>? restaurants;

  ApiSearchResult({this.recipes, this.restaurants});

  ApiSearchResult.fromJson(Map<String, dynamic> json) {
    if (json['recipes'] != null) {
      recipes = <RecipeModel>[];
      json['recipes'].forEach((v) {
        recipes!.add(RecipeModel.fromJson(v));
      });
    }
    if (json['restaurants'] != null) {
      restaurants = <RestaurantModel>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(RestaurantModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (recipes != null) {
      data['recipes'] = recipes!.map((v) => v.toJson()).toList();
    }
    if (restaurants != null) {
      data['restaurants'] = restaurants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecipeModel {
  String? id;
  String? name;
  String? author;
  int? time;
  String? imageUrl;
  String? reason;

  RecipeModel(
      {this.id, this.name, this.author, this.time, this.imageUrl, this.reason});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    author = json['author'];
    time = json['time'];
    imageUrl = json['imageUrl'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['author'] = author;
    data['time'] = time;
    data['imageUrl'] = imageUrl;
    data['reason'] = reason;
    return data;
  }
}

class RestaurantModel {
  String? id;
  String? name;
  double? rating;
  String? imageUrl;
  String? reason;

  RestaurantModel(
      {this.id, this.name, this.rating, this.imageUrl, this.reason});

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'];
    imageUrl = json['imageUrl'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['rating'] = rating;
    data['imageUrl'] = imageUrl;
    data['reason'] = reason;
    return data;
  }
}
