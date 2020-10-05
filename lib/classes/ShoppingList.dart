class ShoppingList {
  String name;
  int qty;
  double price;
  bool purchased;
  String note;

  ShoppingList(this.name, this.qty, this.price, this.note, this.purchased);

  Map<String, dynamic> toJson() => {
        'name': name,
        'qty': qty,
        'price': price,
        "purchased": purchased,
        "note": note
      };
}
