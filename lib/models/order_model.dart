class Order {
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

  Order({
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

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['Id'] as int? ?? 0,
      siparisId: json['SiparisId'] as int? ?? 0,
      siparisSatirId: json['SiparisSatirId'] as int? ?? 0,
      urunId: json['UrunId'] as int? ?? 0,
      urunStokId: json['UrunStokId'] as int? ?? 0,
      resimAdi: json['ResimAdi'] as String? ?? '',
      urunAdi: json['UrunAdi'] as String? ?? '',
      urunKodu: json['UrunKodu'] as String? ?? '',
      barcode: json['Barcode'] as String? ?? '',
      gonderildi: json['Gonderildi'] as bool? ?? false,
      aktifMi: json['AktifMi'] as bool? ?? false,
      gonderedenUyeId: json['GonderedenUyeId'] as int? ?? 0,
      storeCode: json['StoreCode'] as String? ?? '',
      gonderimTarihi: json['GonderimTarihi'] != null
          ? DateTime.parse(json['GonderimTarihi'])
          : null,
      oncelikSonZaman: json['OncelikSonZaman'] != null
          ? DateTime.parse(json['OncelikSonZaman'])
          : null,
      oncelikliStoreId: json['OncelikliStoreId'] as String? ?? '',
      siparisKonum: json['SiparisKonum'] as int? ?? 0,
      isLock: json['IsLock'] as bool? ?? false,
      availableStore: json['AvailableStore'] as String? ?? '',
    );
  }
}
