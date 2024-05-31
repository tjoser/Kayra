class NebimOrder {
  final int id;
  final int siparisId;
  final int siparisSatirId;
  final int urunId;
  final int urunStokId;
  final String resimAdi;
  final String urunAdi;
  final String urunKodu;
  final String barcode;
  final bool gonderildi;
  final bool aktifMi;
  final int gonderedenUyeId;
  final String storeCode;
  final DateTime? gonderimTarihi;
  final DateTime? oncelikSonZaman;
  final String oncelikliStoreId;
  final int siparisKonum;
  final bool isLock;
  final String availableStore;

  NebimOrder({
    required this.id,
    required this.siparisId,
    required this.siparisSatirId,
    required this.urunId,
    required this.urunStokId,
    required this.resimAdi,
    required this.urunAdi,
    required this.urunKodu,
    required this.barcode,
    required this.gonderildi,
    required this.aktifMi,
    required this.gonderedenUyeId,
    required this.storeCode,
    this.gonderimTarihi,
    this.oncelikSonZaman,
    required this.oncelikliStoreId,
    required this.siparisKonum,
    required this.isLock,
    required this.availableStore,
  });

  factory NebimOrder.fromJson(Map<String, dynamic> json) {
    return NebimOrder(
      id: json['Id'] ?? 0,
      siparisId: json['SiparisId'] ?? 0,
      siparisSatirId: json['SiparisSatirId'] ?? 0,
      urunId: json['UrunId'] ?? 0,
      urunStokId: json['UrunStokId'] ?? 0,
      resimAdi: json['ResimAdi'] ?? '',
      urunAdi: json['UrunAdi'] ?? '',
      urunKodu: json['UrunKodu'] ?? '',
      barcode: json['Barcode'] ?? '',
      gonderildi: json['Gonderildi'] ?? false,
      aktifMi: json['AktifMi'] ?? false,
      gonderedenUyeId: json['GonderedenUyeId'] ?? 0,
      storeCode: json['StoreCode'] ?? '',
      gonderimTarihi: json['GonderimTarihi'] != null
          ? DateTime.parse(json['GonderimTarihi'])
          : null,
      oncelikSonZaman: json['OncelikSonZaman'] != null
          ? DateTime.parse(json['OncelikSonZaman'])
          : null,
      oncelikliStoreId: json['OncelikliStoreId'] ?? '',
      siparisKonum: json['SiparisKonum'] ?? 0,
      isLock: json['IsLock'] ?? false,
      availableStore: json['AvailableStore'] ?? '',
    );
  }
}
