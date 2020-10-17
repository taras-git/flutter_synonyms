class Noun {
  Synonym syn;

  Noun({this.syn});

  Noun.fromJson(Map<String, dynamic> json) {
    syn = json['noun'] != null ? new Synonym.fromJson(json['noun']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.syn != null) {
      data['noun'] = this.syn.toJson();
    }
    return data;
  }
}

class Synonym {
  List<String> synonyms;

  Synonym({this.synonyms});

  Synonym.fromJson(Map<String, dynamic> json) {
    synonyms = json['syn'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['syn'] = this.synonyms;
    return data;
  }
}
