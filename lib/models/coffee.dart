class Coffee {
  String name;
  String menuType;
  String menuCategory;
  String drinkType;
  String drinkSize;
  String price;

  Coffee(
      {this.name,
        this.menuType,
        this.menuCategory,
        this.drinkType,
        this.drinkSize,
        this.price});

  Coffee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    menuType = json['menu_type'];
    menuCategory = json['menu_category'];
    drinkType = json['drink_type'];
    drinkSize = json['drink_size'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['menu_type'] = this.menuType;
    data['menu_category'] = this.menuCategory;
    data['drink_type'] = this.drinkType;
    data['drink_size'] = this.drinkSize;
    data['price'] = this.price;
    return data;
  }

  @override
  String toString() {
    return 'Coffee{name: $name, menuType: $menuType, menuCategory: $menuCategory, drinkType: $drinkType, drinkSize: $drinkSize, price: $price}';
  }


}
