class SearchIdModel {
  final String id;

  SearchIdModel({
    required this.id,
  });

  factory SearchIdModel.fromJson(Map<String, dynamic> json) {
    return SearchIdModel(
      id: json['id'] ?? '',
    );
  }
}

class SearchIdDetailModel {
  final String id;
  final String searchText;
  final String createdAt;
  final String? feedback;
  final List<ResultItem> result;

  SearchIdDetailModel({
    required this.id,
    required this.searchText,
    required this.createdAt,
    this.feedback,
    required this.result,
  });

  factory SearchIdDetailModel.fromJson(Map<String, dynamic> json) {
    var resultList = json['result'] as List;
    List<ResultItem> resultItems =
        resultList.map((i) => ResultItem.fromJson(i)).toList();

    return SearchIdDetailModel(
      id: json['id'],
      searchText: json['searchText'],
      createdAt: json['createdAt'],
      feedback: json['feedback'],
      result: resultItems,
    );
  }
}

class ResultItem {
  final String name;
  final String reason;

  ResultItem({required this.name, required this.reason});

  factory ResultItem.fromJson(Map<String, dynamic> json) {
    return ResultItem(
      name: json['name'],
      reason: json['reason'],
    );
  }
}
