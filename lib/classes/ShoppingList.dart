class ShoppingList {
  final String name;
  final int qty;
  final double price;
  final bool purchased;
  final String note;

  ShoppingList(this.name, this.qty, this.price, this.note, this.purchased);

  Map<String, dynamic> toJson() => {
        'name': name,
        'qty': qty,
        'price': price,
        "purchased": purchased,
        "note": note
      };
}
