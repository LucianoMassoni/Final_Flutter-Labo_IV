// To parse this JSON data, do
//
//     final infoPeliculas = infoPeliculasFromJson(jsonString);

import 'dart:convert';

InfoPeliculas infoPeliculasFromJson(String str) => InfoPeliculas.fromJson(json.decode(str));

String infoPeliculasToJson(InfoPeliculas data) => json.encode(data.toJson());

class InfoPeliculas {
    int? page;
    List<Result>? results;
    int? totalPages;
    int? totalResults;

    InfoPeliculas({
        this.page,
        this.results = const [],
        this.totalPages,
        this.totalResults,
    });

    factory InfoPeliculas.fromJson(Map<String, dynamic> json) => InfoPeliculas(
        page: json["page"],
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Result {
    bool? adult;
    String? backdropPath;
    List<int>? genreIds;
    int? id;
    //OriginalLanguage? originalLanguage;
    String? originalTitle;
    String? overview;
    double? popularity;
    String? posterPath;
    DateTime? releaseDate;
    String? title;
    bool? video;
    double? voteAverage;
    int? voteCount;

    Result({
        this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        //this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"],
        //originalLanguage: originalLanguageValues.map[json["original_language"]]!,
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        //releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
        releaseDate: json["release_date"] != null ? DateTime.parse(json["release_date"]) : null,
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        //"original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
       "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}

enum OriginalLanguage {
    AR,
    EN,
    HI,
    JA,
    KO,
    MN
}

final originalLanguageValues = EnumValues({
    "ar": OriginalLanguage.AR,
    "en": OriginalLanguage.EN,
    "hi": OriginalLanguage.HI,
    "ja": OriginalLanguage.JA,
    "ko": OriginalLanguage.KO,
    "mn": OriginalLanguage.MN
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}