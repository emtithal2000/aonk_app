class DonationTypes {
  int? id;
  String? nameAr;
  String? nameEn;

  DonationTypes({this.id, this.nameAr, this.nameEn});

  DonationTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}
