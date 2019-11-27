class Store {
  String name;
  int supplierId;
  String branch;
  String address;
  String zipcode;
  String phone;
  String latitude;
  String longitude;

  Store(
      {this.name,
        this.supplierId,
        this.branch,
        this.address,
        this.zipcode,
        this.phone,
        this.latitude,
        this.longitude});

  Store.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    supplierId = json['supplier_id'];
    branch = json['branch'];
    address = json['address'];
    zipcode = json['zipcode'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['supplier_id'] = this.supplierId;
    data['branch'] = this.branch;
    data['address'] = this.address;
    data['zipcode'] = this.zipcode;
    data['phone'] = this.phone;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
