class modelRekPajak {
  String idRekening;
  String kodeRekening;
  String namaRekening;
  String rumus;
  String tarif;

  modelRekPajak(this.idRekening, this.kodeRekening, this.namaRekening,
      this.rumus, this.tarif);

  // Add a factory constructor to convert from JSON
  factory modelRekPajak.fromJson(Map<String, dynamic> json) {
    return modelRekPajak(
      json['id_rekening'],
      json['kode_rekening'],
      json['nama_rekening'],
      json['rumus'],
      json['tarif'],
    );
  }

  // Add a toJson method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id_rekening': idRekening,
      'kode_rekening': kodeRekening,
      'nama_rekening': namaRekening,
      'rumus': rumus,
      'tarif': tarif,
    };
  }
}
