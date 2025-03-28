class AddressModel {
  String addressLine1;
  String? addressLine2;
  String city;
  String zipCode;
  String phoneNumber;

  AddressModel({
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.zipCode,
    required this.phoneNumber,
  });
}