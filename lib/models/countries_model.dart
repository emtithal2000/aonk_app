class Countries {
  List<City>? cities;
  Country? country;

  Countries({this.cities, this.country});

  Countries.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <City>[];
      json['cities'].forEach((v) {
        cities!.add(City.fromJson(v));
      });
    }
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    return data;
  }
}

class City {
  String? cityAr;
  String? cityEn;
  int? cityId;

  City({this.cityAr, this.cityEn, this.cityId});

  City.fromJson(Map<String, dynamic> json) {
    cityAr = json['city_ar'];
    cityEn = json['city_en'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_ar'] = cityAr;
    data['city_en'] = cityEn;
    data['city_id'] = cityId;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_ar'] = countryAr;
    data['name_en'] = countryEn;
    data['id'] = countryId;
    return data;
  }
}
