class InOutParamModel {
  int qtyInOut;
  String date;
  String status;
  int ?warehouseItemId;
  String aktor;

  InOutParamModel({
    required this.qtyInOut,
    required this.date,
    required this.status,
    required this.warehouseItemId,
    required this.aktor,
  });

  Map<String, dynamic> toJson() {
    return {
      'qtyInOut': qtyInOut,
      'date': date,
      'status': status,
      'warehouseItemId': warehouseItemId,
      'aktor': aktor,
    };
  }
}
