class Countries {
  List<Cities>? cities;
  Country? country;

  Countries({this.cities, this.country});

  Countries.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
  }
}

class Cities {
  String? cityAr;
  String? cityEn;
  int? cityId;

  Cities({this.cityAr, this.cityEn, this.cityId});

  Cities.fromJson(Map<String, dynamic> json) {
    cityAr = json['city_ar'];
    cityEn = json['city_en'];
    cityId = json['city_id'];
  }
}

class Country {
  String? countryAr;
  String? countryEn;
  int? countryId;

  Country({this.countryAr, this.countryEn, this.countryId});

  Country.fromJson(Map<String, dynamic> json) {
    countryAr = json['name_ar'];
    countryEn = json['name_en'];
    countryId = json['id'];
  }
}
