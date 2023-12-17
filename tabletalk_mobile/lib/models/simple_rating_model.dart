class SimpleRatingModel {
  final String id;
  final String name;
  final double rating;
  final String imageUrl;
  final RateFor rateFor;
  final String referenceId;

  SimpleRatingModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.imageUrl,
    required this.rateFor,
    required this.referenceId,
  });

  factory SimpleRatingModel.fromJson(Map<String, dynamic> json) {
    return SimpleRatingModel(
      id: json['id'],
      name: json['name'],
      rating: json['rating'].toDouble(),
      imageUrl: json['imageUrl'],
      rateFor: RateForExtension.fromString(json['rateFor']),
      referenceId: json['referenceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'imageUrl': imageUrl,
      'rateFor': rateFor.string,
      'referenceId': referenceId,
    };
  }
}

enum RateFor { restaurant, recipe }

extension RateForExtension on RateFor {
  String get string {
    switch (this) {
      case RateFor.restaurant:
        return 'restaurant';
      case RateFor.recipe:
        return 'recipe';
      default:
        return '';
    }
  }

  static RateFor fromString(String str) {
    switch (str) {
      case 'restaurant':
        return RateFor.restaurant;
      case 'recipe':
        return RateFor.recipe;
      default:
        return RateFor
            .restaurant;
    }
  }
}
