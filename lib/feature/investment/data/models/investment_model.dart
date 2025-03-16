import 'dart:convert';  

class InvestmentModel {  
  final int id;  
  final String image;  
  final String houseNumber;  
  final String street;  
  final String state;  
  final String zipCode;  
  final String country;  

  const InvestmentModel({  
    required this.id,  
    required this.image,  
    required this.houseNumber,  
    required this.street,  
    required this.state,  
    required this.zipCode,  
    required this.country,  
  });  

  factory InvestmentModel.fromJson(Map<String, dynamic> json) {  
    return InvestmentModel(  
      id: json['id']??1,  
      image: json['image']??'https://cms-assets.themuse.com/media/lead/_1200x630_crop_center-center_82_none/what-is-real-estate.png?mtime=1721326416',  
      houseNumber: json['HouseNumber'],  
      street: json['Street'],  
      state: json['State'],  
      zipCode: json['ZipCode'],  
      country: json['Country'],  
    );  
  }  
}  