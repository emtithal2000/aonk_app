import 'package:aonk_app/models/countries_model.dart';

class CharitiesModel {
  Charity? charity;
  Cities? city;
  String? contactPhone;
  Country? country;
  String? descriptionAr;
  String? descriptionEn;
  bool? isnamed;
  String? logo;
  String? website;

  CharitiesModel(
      {this.charity,
      this.city,
      this.contactPhone,
      this.country,
      this.descriptionAr,
      this.descriptionEn,
      this.isnamed,
      this.logo,
      this.website});

  CharitiesModel.fromJson(Map<String, dynamic> json) {
    charity =
        json['charity'] != null ? Charity.fromJson(json['charity']) : null;
    city = json['city'] != null ? Cities.fromJson(json['city']) : null;
    contactPhone = json['contact_phone'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    isnamed = json['isnamed'];
    logo = json['logo'];
    website = json['website'];
  }
}

class Charity {
  int? id;
  String? nameAr;
  String? nameEn;

  Charity({this.id, this.nameAr, this.nameEn});

  Charity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}
