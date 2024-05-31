class ReportProblemResponse {
  final int id;
  final int sorunBildirenKullaniciId;
  final String storeCode;
  final int sorunId;
  final String sorun;
  final String aktifMagazalar;
  final String sorunluUrunBarcode;
  final String aciklama;
  final bool aktifMi;
  final int siparisId;
  final String resimAdi;
  final String magazaIsim;

  ReportProblemResponse({
    required this.id,
    required this.sorunBildirenKullaniciId,
    required this.storeCode,
    required this.sorunId,
    required this.sorun,
    required this.aktifMagazalar,
    required this.sorunluUrunBarcode,
    required this.aciklama,
    required this.aktifMi,
    required this.siparisId,
    required this.resimAdi,
    required this.magazaIsim,
  });

  factory ReportProblemResponse.fromJson(Map<String, dynamic> json) {
    return ReportProblemResponse(
      id: json['Id'] ?? 0,
      sorunBildirenKullaniciId: json['SorunBildirenKullaniciId'] ?? 0,
      storeCode: json['StoreCode'] ?? '',
      sorunId: json['SorunId'] ?? 0,
      sorun: json['Sorun'] ?? '',
      aktifMagazalar: json['AktifMagazalar'] ?? '',
      sorunluUrunBarcode: json['SorunluUrunBarcode'] ?? '',
      aciklama: json['Aciklama'] ?? '',
      aktifMi: json['AktifMi'] ?? false,
      siparisId: json['SiparisId'] ?? 0,
      resimAdi: json['ResimAdi'] ?? '',
      magazaIsim: json['MagazaIsim'] ?? '',
    );
  }
}
