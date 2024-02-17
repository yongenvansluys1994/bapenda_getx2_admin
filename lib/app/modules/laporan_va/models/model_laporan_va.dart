import 'dart:math';

class ModelLaporanVa {
  String number;
  DateTime trxDate;
  String amount;
  String reference;
  String? jenisPajak;

  ModelLaporanVa({
    required this.number,
    required this.trxDate,
    required this.amount,
    required this.reference,
    required this.jenisPajak,
  });

  factory ModelLaporanVa.fromJson(Map<String, dynamic> json) {
    String truncatedNumber = (json['number'] as String)
        .substring(max(0, (json['number'] as String).length - 10));
    // Extracting the last 10 digits of 'number'

    return ModelLaporanVa(
      number: truncatedNumber,
      trxDate: DateTime.parse(json["trx_date"]),
      amount: json["amount"],
      reference: json["reference"],
      jenisPajak: json["jenispajak"],
    );
  }

  Map<String, dynamic> toJson() => {
        "number": number,
        "trx_date":
            "${trxDate.year.toString().padLeft(4, '0')}-${trxDate.month.toString().padLeft(2, '0')}-${trxDate.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "reference": reference,
        "jenispajak": jenisPajak,
      };
}
