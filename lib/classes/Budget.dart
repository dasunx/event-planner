class Budget {
  double budget;
  double paidAmount;
  String note;

  Budget(this.budget, this.paidAmount, this.note);

  Map<String, dynamic> toJson() =>
      {'budget': budget, 'paidAmount': paidAmount, "note": note};
}
