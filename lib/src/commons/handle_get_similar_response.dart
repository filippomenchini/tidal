List<String> handleGetSimilarResponse(Map<String, dynamic> json) =>
    (json["data"] as List<dynamic>)
        .map((e) => e["resource"]["id"].toString())
        .toList();
