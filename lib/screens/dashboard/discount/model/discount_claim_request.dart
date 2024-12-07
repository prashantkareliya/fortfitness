class DiscountClaimRequest {
  String? discountId;
  String? amount;
  String? receipt;

  DiscountClaimRequest({this.discountId, this.amount, this.receipt});

  DiscountClaimRequest.fromJson(Map<String, dynamic> json) {
    discountId = json['discount_id'];
    amount = json['amount'];
    receipt = json['receipt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount_id'] = this.discountId;
    data['amount'] = this.amount;
    data['receipt'] = this.receipt;
    return data;
  }
}
