class UserOrderDetail {
  final int id;
  final int olusturanKullaniciId;
  final DateTime? olusturmaTarihi;
  final int degistirenKullaniciId;
  final DateTime? degistirmeTarihi;
  final String siparisNo;
  final int uyeId;
  final double toplam;
  final double toplamDoviz;
  final double dovizCarpan;
  final double indirimToplami;
  final double indirimToplamiDoviz;
  final double gonderimUcreti;
  final double gonderimUcretiDoviz;
  final double toplamKdv;
  final double toplamKdvDoviz;
  final double genelToplam;
  final double genelToplamDoviz;
  final int siparisDurumu;
  final int iadeDurumu;
  final int kargoId;
  final int kuponId;
  final double kuponTutar;
  final int faturaTipi;
  final int faturaAdresiTeslimatAdresiIleAyni;
  final String firmaAdi;
  final String vergiDairesi;
  final String vergiNo;
  final double dovizTutar;
  final int dovizId;
  final String faturaAdres1;
  final String faturaAdres2;
  final String faturaAdres3;
  final String teslimatAdres1;
  final String teslimatAdres2;
  final String teslimatAdres3;
  final String teslimAlanAdSoyad;
  final String faturaTeslimAlanAdSoyad;
  final String faturaTelefon;
  final String teslimatTelefon;
  final String faturaPostaKodu;
  final String teslimatPostaKodu;
  final List<SiparisSatir> siparisSatir;
  final List<Fatura> fatura;
  final List<OdemeTur> odemeTurs;
  final Sozlesme sozlesme;

  UserOrderDetail({
    required this.id,
    required this.olusturanKullaniciId,
    this.olusturmaTarihi,
    required this.degistirenKullaniciId,
    this.degistirmeTarihi,
    required this.siparisNo,
    required this.uyeId,
    required this.toplam,
    required this.toplamDoviz,
    required this.dovizCarpan,
    required this.indirimToplami,
    required this.indirimToplamiDoviz,
    required this.gonderimUcreti,
    required this.gonderimUcretiDoviz,
    required this.toplamKdv,
    required this.toplamKdvDoviz,
    required this.genelToplam,
    required this.genelToplamDoviz,
    required this.siparisDurumu,
    required this.iadeDurumu,
    required this.kargoId,
    required this.kuponId,
    required this.kuponTutar,
    required this.faturaTipi,
    required this.faturaAdresiTeslimatAdresiIleAyni,
    required this.firmaAdi,
    required this.vergiDairesi,
    required this.vergiNo,
    required this.dovizTutar,
    required this.dovizId,
    required this.faturaAdres1,
    required this.faturaAdres2,
    required this.faturaAdres3,
    required this.teslimatAdres1,
    required this.teslimatAdres2,
    required this.teslimatAdres3,
    required this.teslimAlanAdSoyad,
    required this.faturaTeslimAlanAdSoyad,
    required this.faturaTelefon,
    required this.teslimatTelefon,
    required this.faturaPostaKodu,
    required this.teslimatPostaKodu,
    required this.siparisSatir,
    required this.fatura,
    required this.odemeTurs,
    required this.sozlesme,
  });

  factory UserOrderDetail.fromJson(Map<String, dynamic> json) {
    return UserOrderDetail(
      id: json['Id'] ?? 0,
      olusturanKullaniciId: json['OlusturanKullaniciId'] ?? 0,
      olusturmaTarihi: json['OlusturmaTarihi'] != null
          ? DateTime.parse(json['OlusturmaTarihi'])
          : null,
      degistirenKullaniciId: json['DegistirenKullaniciId'] ?? 0,
      degistirmeTarihi: json['DegistirmeTarihi'] != null
          ? DateTime.parse(json['DegistirmeTarihi'])
          : null,
      siparisNo: json['SiparisNo'] ?? '',
      uyeId: json['UyeId'] ?? 0,
      toplam: json['Toplam']?.toDouble() ?? 0.0,
      toplamDoviz: json['ToplamDoviz']?.toDouble() ?? 0.0,
      dovizCarpan: json['DovizCarpan']?.toDouble() ?? 0.0,
      indirimToplami: json['IndirimToplami']?.toDouble() ?? 0.0,
      indirimToplamiDoviz: json['IndirimToplamiDoviz']?.toDouble() ?? 0.0,
      gonderimUcreti: json['GonderimUcreti']?.toDouble() ?? 0.0,
      gonderimUcretiDoviz: json['GonderimUcretiDoviz']?.toDouble() ?? 0.0,
      toplamKdv: json['ToplamKdv']?.toDouble() ?? 0.0,
      toplamKdvDoviz: json['ToplamKdvDoviz']?.toDouble() ?? 0.0,
      genelToplam: json['GenelToplam']?.toDouble() ?? 0.0,
      genelToplamDoviz: json['GenelToplamDoviz']?.toDouble() ?? 0.0,
      siparisDurumu: json['SiparisDurumu'] ?? 0,
      iadeDurumu: json['IadeDurumu'] ?? 0,
      kargoId: json['KargoId'] ?? 0,
      kuponId: json['KuponId'] ?? 0,
      kuponTutar: json['KuponTutar']?.toDouble() ?? 0.0,
      faturaTipi: json['FaturaTipi'] ?? 0,
      faturaAdresiTeslimatAdresiIleAyni:
          json['FaturaAdresiTeslimatAdresiIleAyni'] ?? 0,
      firmaAdi: json['FirmaAdi'] ?? '',
      vergiDairesi: json['VergiDairesi'] ?? '',
      vergiNo: json['VergiNo'] ?? '',
      dovizTutar: json['DovizTutar']?.toDouble() ?? 0.0,
      dovizId: json['DovizId'] ?? 0,
      faturaAdres1: json['FaturaAdres1'] ?? '',
      faturaAdres2: json['FaturaAdres2'] ?? '',
      faturaAdres3: json['FaturaAdres3'] ?? '',
      teslimatAdres1: json['TeslimatAdres1'] ?? '',
      teslimatAdres2: json['TeslimatAdres2'] ?? '',
      teslimatAdres3: json['TeslimatAdres3'] ?? '',
      teslimAlanAdSoyad: json['TeslimAlanAdSoyad'] ?? '',
      faturaTeslimAlanAdSoyad: json['FaturaTeslimAlanAdSoyad'] ?? '',
      faturaTelefon: json['FaturaTelefon'] ?? '',
      teslimatTelefon: json['TeslimatTelefon'] ?? '',
      faturaPostaKodu: json['FaturaPostaKodu'] ?? '',
      teslimatPostaKodu: json['TeslimatPostaKodu'] ?? '',
      siparisSatir: (json['SiparisSatir'] as List<dynamic>?)
              ?.map((item) => SiparisSatir.fromJson(item))
              .toList() ??
          [],
      fatura: (json['Fatura'] as List<dynamic>?)
              ?.map((item) => Fatura.fromJson(item))
              .toList() ??
          [],
      odemeTurs: (json['OdemeTurs'] as List<dynamic>?)
              ?.map((item) => OdemeTur.fromJson(item))
              .toList() ??
          [],
      sozlesme: json['Sozlesme'] != null
          ? Sozlesme.fromJson(json['Sozlesme'])
          : Sozlesme.empty(),
    );
  }
}

class SiparisSatir {
  final int miktar;
  final double birimFiyat;
  final double birimFiyatDoviz;
  final int birim;
  final double kdvOrani;
  final double satirKuponIndirimi;
  final double satirKuponIndirimiDoviz;
  final double satirKuponIndirimiOrani;
  final double satirOdemeYontemiIndirimi;
  final double satirOdemeYontemiIndirimiDoviz;
  final double satirOdemeYontemiIndirimiOrani;
  final double satirIndirimToplami;
  final double satirIndirimToplamiDoviz;
  final double satirIndirimOrani;
  final int id;
  final DateTime? olusturmaTarihi;
  final int olusturanKullaniciId;
  final bool aktifMi;
  final int siparisId;
  final int tur;
  final String aciklama;
  final String baseAciklama;
  final double satirToplami;
  final double satirToplamiDoviz;
  final double dovizTutar;
  final int dovizId;
  final int siparisSatirDurumu;
  final int iptalIadeEdilenMiktar;
  final String kargoNo;
  final String kaynakId;
  final String kullaniciAciklama;
  final int urunId;
  final int urunStokId;
  final DateTime? degistirmeTarihi;
  final int degistirenKullaniciId;
  final double satisFiyat;
  final double satisFiyatDoviz;
  final double satisFiyat1;
  final double satisFiyat1Doviz;
  final double satisFiyat2;
  final double satisFiyat2Doviz;
  final double satisFiyat3;
  final double satisFiyat3Doviz;
  final double satisFiyat4;
  final double satisFiyat4Doviz;
  final double satisFiyat5;
  final double satisFiyat5Doviz;
  final double alisFiyat;
  final int kampanyaId;
  final int siparisSatirTurEnum;
  final int siparisSatirDurumuEnum;

  SiparisSatir({
    required this.miktar,
    required this.birimFiyat,
    required this.birimFiyatDoviz,
    required this.birim,
    required this.kdvOrani,
    required this.satirKuponIndirimi,
    required this.satirKuponIndirimiDoviz,
    required this.satirKuponIndirimiOrani,
    required this.satirOdemeYontemiIndirimi,
    required this.satirOdemeYontemiIndirimiDoviz,
    required this.satirOdemeYontemiIndirimiOrani,
    required this.satirIndirimToplami,
    required this.satirIndirimToplamiDoviz,
    required this.satirIndirimOrani,
    required this.id,
    this.olusturmaTarihi,
    required this.olusturanKullaniciId,
    required this.aktifMi,
    required this.siparisId,
    required this.tur,
    required this.aciklama,
    required this.baseAciklama,
    required this.satirToplami,
    required this.satirToplamiDoviz,
    required this.dovizTutar,
    required this.dovizId,
    required this.siparisSatirDurumu,
    required this.iptalIadeEdilenMiktar,
    required this.kargoNo,
    required this.kaynakId,
    required this.kullaniciAciklama,
    required this.urunId,
    required this.urunStokId,
    this.degistirmeTarihi,
    required this.degistirenKullaniciId,
    required this.satisFiyat,
    required this.satisFiyatDoviz,
    required this.satisFiyat1,
    required this.satisFiyat1Doviz,
    required this.satisFiyat2,
    required this.satisFiyat2Doviz,
    required this.satisFiyat3,
    required this.satisFiyat3Doviz,
    required this.satisFiyat4,
    required this.satisFiyat4Doviz,
    required this.satisFiyat5,
    required this.satisFiyat5Doviz,
    required this.alisFiyat,
    required this.kampanyaId,
    required this.siparisSatirTurEnum,
    required this.siparisSatirDurumuEnum,
  });

  factory SiparisSatir.fromJson(Map<String, dynamic> json) {
    return SiparisSatir(
      miktar: json['Miktar'] ?? 0,
      birimFiyat: json['BirimFiyat']?.toDouble() ?? 0.0,
      birimFiyatDoviz: json['BirimFiyatDoviz']?.toDouble() ?? 0.0,
      birim: json['Birim'] ?? 0,
      kdvOrani: json['KdvOrani']?.toDouble() ?? 0.0,
      satirKuponIndirimi: json['SatirKuponIndirimi']?.toDouble() ?? 0.0,
      satirKuponIndirimiDoviz:
          json['SatirKuponIndirimiDoviz']?.toDouble() ?? 0.0,
      satirKuponIndirimiOrani:
          json['SatirKuponIndirimiOrani']?.toDouble() ?? 0.0,
      satirOdemeYontemiIndirimi:
          json['SatirOdemeYontemiIndirimi']?.toDouble() ?? 0.0,
      satirOdemeYontemiIndirimiDoviz:
          json['SatirOdemeYontemiIndirimiDoviz']?.toDouble() ?? 0.0,
      satirOdemeYontemiIndirimiOrani:
          json['SatirOdemeYontemiIndirimiOrani']?.toDouble() ?? 0.0,
      satirIndirimToplami: json['SatirIndirimToplami']?.toDouble() ?? 0.0,
      satirIndirimToplamiDoviz:
          json['SatirIndirimToplamiDoviz']?.toDouble() ?? 0.0,
      satirIndirimOrani: json['SatirIndirimOrani']?.toDouble() ?? 0.0,
      id: json['Id'] ?? 0,
      olusturmaTarihi: json['OlusturmaTarihi'] != null
          ? DateTime.parse(json['OlusturmaTarihi'])
          : null,
      olusturanKullaniciId: json['OlusturanKullaniciId'] ?? 0,
      aktifMi: json['AktifMi'] ?? false,
      siparisId: json['SiparisId'] ?? 0,
      tur: json['Tur'] ?? 0,
      aciklama: json['Aciklama'] ?? '',
      baseAciklama: json['BaseAciklama'] ?? '',
      satirToplami: json['SatirToplami']?.toDouble() ?? 0.0,
      satirToplamiDoviz: json['SatirToplamiDoviz']?.toDouble() ?? 0.0,
      dovizTutar: json['DovizTutar']?.toDouble() ?? 0.0,
      dovizId: json['DovizId'] ?? 0,
      siparisSatirDurumu: json['SiparisSatirDurumu'] ?? 0,
      iptalIadeEdilenMiktar: json['IptalIadeEdilenMiktar'] ?? 0,
      kargoNo: json['KargoNo'] ?? '',
      kaynakId: json['KaynakId'] ?? '',
      kullaniciAciklama: json['KullaniciAciklama'] ?? '',
      urunId: json['UrunId'] ?? 0,
      urunStokId: json['UrunStokId'] ?? 0,
      degistirmeTarihi: json['DegistirmeTarihi'] != null
          ? DateTime.parse(json['DegistirmeTarihi'])
          : null,
      degistirenKullaniciId: json['DegistirenKullaniciId'] ?? 0,
      satisFiyat: json['SatisFiyat']?.toDouble() ?? 0.0,
      satisFiyatDoviz: json['SatisFiyatDoviz']?.toDouble() ?? 0.0,
      satisFiyat1: json['SatisFiyat1']?.toDouble() ?? 0.0,
      satisFiyat1Doviz: json['SatisFiyat1Doviz']?.toDouble() ?? 0.0,
      satisFiyat2: json['SatisFiyat2']?.toDouble() ?? 0.0,
      satisFiyat2Doviz: json['SatisFiyat2Doviz']?.toDouble() ?? 0.0,
      satisFiyat3: json['SatisFiyat3']?.toDouble() ?? 0.0,
      satisFiyat3Doviz: json['SatisFiyat3Doviz']?.toDouble() ?? 0.0,
      satisFiyat4: json['SatisFiyat4']?.toDouble() ?? 0.0,
      satisFiyat4Doviz: json['SatisFiyat4Doviz']?.toDouble() ?? 0.0,
      satisFiyat5: json['SatisFiyat5']?.toDouble() ?? 0.0,
      satisFiyat5Doviz: json['SatisFiyat5Doviz']?.toDouble() ?? 0.0,
      alisFiyat: json['AlisFiyat']?.toDouble() ?? 0.0,
      kampanyaId: json['KampanyaId'] ?? 0,
      siparisSatirTurEnum: json['SiparisSatirTurEnum'] ?? 0,
      siparisSatirDurumuEnum: json['SiparisSatirDurumuEnum'] ?? 0,
    );
  }
}

class Fatura {
  final int id;
  final int siparisId;
  final int uyeId;
  final int faturaId;
  final String faturaNo;
  final DateTime? faturaTarihi;
  final String aciklama;
  final double genelToplam;
  final double toplam;
  final double indirimToplami;
  final double toplamKdv;
  final String kargoNo;
  final int faturaDurumu;
  final String kargoAdi;
  final String kargoLogo;
  final String kargoURL;
  final List<FaturaSatir> faturaSatir;

  Fatura({
    required this.id,
    required this.siparisId,
    required this.uyeId,
    required this.faturaId,
    required this.faturaNo,
    this.faturaTarihi,
    required this.aciklama,
    required this.genelToplam,
    required this.toplam,
    required this.indirimToplami,
    required this.toplamKdv,
    required this.kargoNo,
    required this.faturaDurumu,
    required this.kargoAdi,
    required this.kargoLogo,
    required this.kargoURL,
    required this.faturaSatir,
  });

  factory Fatura.fromJson(Map<String, dynamic> json) {
    return Fatura(
      id: json['Id'] ?? 0,
      siparisId: json['SiparisId'] ?? 0,
      uyeId: json['UyeId'] ?? 0,
      faturaId: json['FaturaId'] ?? 0,
      faturaNo: json['FaturaNo'] ?? '',
      faturaTarihi: json['FaturaTarihi'] != null
          ? DateTime.parse(json['FaturaTarihi'])
          : null,
      aciklama: json['Aciklama'] ?? '',
      genelToplam: json['GenelToplam']?.toDouble() ?? 0.0,
      toplam: json['Toplam']?.toDouble() ?? 0.0,
      indirimToplami: json['IndirimToplami']?.toDouble() ?? 0.0,
      toplamKdv: json['ToplamKdv']?.toDouble() ?? 0.0,
      kargoNo: json['KargoNo'] ?? '',
      faturaDurumu: json['FaturaDurumu'] ?? 0,
      kargoAdi: json['KargoAdi'] ?? '',
      kargoLogo: json['KargoLogo'] ?? '',
      kargoURL: json['KargoURL'] ?? '',
      faturaSatir: (json['FaturaSatir'] as List<dynamic>?)
              ?.map((item) => FaturaSatir.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class FaturaSatir {
  final int id;
  final int faturaId;
  final int siparisSatirId;
  final int tur;
  final int urunId;
  final int urunStokId;
  final String aciklama;
  final int miktar;
  final double birimFiyat;
  final int birim;
  final double kdvOrani;
  final double satirKuponIndirimi;
  final double satirKuponIndirimiOrani;
  final double satirOdemeYontemiIndirimi;
  final double satirOdemeYontemiIndirimiOrani;
  final double satirIndirimToplami;
  final double satirIndirimOrani;
  final double satisFiyat;
  final double satisFiyat1;
  final double satisFiyat2;
  final double satisFiyat3;
  final double satisFiyat4;
  final double satisFiyat5;
  final double alisFiyat;
  final double satirToplami;
  final double dovizTutar;
  final int dovizId;
  final String kaynakId;
  final bool aktifMi;
  final int faturaSatirTurEnum;
  final String urunAdi;
  final Resim resim;
  final int iadeTurId;
  final int iadeTurNedenId;
  final List<OncekiIadeler> oncekiIadeler;
  final bool yeniEklendiMi;
  final bool iadeSozlesmesiOnayi;

  FaturaSatir({
    required this.id,
    required this.faturaId,
    required this.siparisSatirId,
    required this.tur,
    required this.urunId,
    required this.urunStokId,
    required this.aciklama,
    required this.miktar,
    required this.birimFiyat,
    required this.birim,
    required this.kdvOrani,
    required this.satirKuponIndirimi,
    required this.satirKuponIndirimiOrani,
    required this.satirOdemeYontemiIndirimi,
    required this.satirOdemeYontemiIndirimiOrani,
    required this.satirIndirimToplami,
    required this.satirIndirimOrani,
    required this.satisFiyat,
    required this.satisFiyat1,
    required this.satisFiyat2,
    required this.satisFiyat3,
    required this.satisFiyat4,
    required this.satisFiyat5,
    required this.alisFiyat,
    required this.satirToplami,
    required this.dovizTutar,
    required this.dovizId,
    required this.kaynakId,
    required this.aktifMi,
    required this.faturaSatirTurEnum,
    required this.urunAdi,
    required this.resim,
    required this.iadeTurId,
    required this.iadeTurNedenId,
    required this.oncekiIadeler,
    required this.yeniEklendiMi,
    required this.iadeSozlesmesiOnayi,
  });

  factory FaturaSatir.fromJson(Map<String, dynamic> json) {
    return FaturaSatir(
      id: json['Id'] ?? 0,
      faturaId: json['FaturaId'] ?? 0,
      siparisSatirId: json['SiparisSatirId'] ?? 0,
      tur: json['Tur'] ?? 0,
      urunId: json['UrunId'] ?? 0,
      urunStokId: json['UrunStokId'] ?? 0,
      aciklama: json['Aciklama'] ?? '',
      miktar: json['Miktar'] ?? 0,
      birimFiyat: json['BirimFiyat']?.toDouble() ?? 0.0,
      birim: json['Birim'] ?? 0,
      kdvOrani: json['KdvOrani']?.toDouble() ?? 0.0,
      satirKuponIndirimi: json['SatirKuponIndirimi']?.toDouble() ?? 0.0,
      satirKuponIndirimiOrani:
          json['SatirKuponIndirimiOrani']?.toDouble() ?? 0.0,
      satirOdemeYontemiIndirimi:
          json['SatirOdemeYontemiIndirimi']?.toDouble() ?? 0.0,
      satirOdemeYontemiIndirimiOrani:
          json['SatirOdemeYontemiIndirimiOrani']?.toDouble() ?? 0.0,
      satirIndirimToplami: json['SatirIndirimToplami']?.toDouble() ?? 0.0,
      satirIndirimOrani: json['SatirIndirimOrani']?.toDouble() ?? 0.0,
      satisFiyat: json['SatisFiyat']?.toDouble() ?? 0.0,
      satisFiyat1: json['SatisFiyat1']?.toDouble() ?? 0.0,
      satisFiyat2: json['SatisFiyat2']?.toDouble() ?? 0.0,
      satisFiyat3: json['SatisFiyat3']?.toDouble() ?? 0.0,
      satisFiyat4: json['SatisFiyat4']?.toDouble() ?? 0.0,
      satisFiyat5: json['SatisFiyat5']?.toDouble() ?? 0.0,
      alisFiyat: json['AlisFiyat']?.toDouble() ?? 0.0,
      satirToplami: json['SatirToplami']?.toDouble() ?? 0.0,
      dovizTutar: json['DovizTutar']?.toDouble() ?? 0.0,
      dovizId: json['DovizId'] ?? 0,
      kaynakId: json['KaynakId'] ?? '',
      aktifMi: json['AktifMi'] ?? false,
      faturaSatirTurEnum: json['FaturaSatirTurEnum'] ?? 0,
      urunAdi: json['UrunAdi'] ?? '',
      resim:
          json['Resim'] != null ? Resim.fromJson(json['Resim']) : Resim.empty(),
      iadeTurId: json['IadeTurId'] ?? 0,
      iadeTurNedenId: json['IadeTurNedenId'] ?? 0,
      oncekiIadeler: (json['OncekiIadeler'] as List<dynamic>?)
              ?.map((item) => OncekiIadeler.fromJson(item))
              .toList() ??
          [],
      yeniEklendiMi: json['YeniEklendiMi'] ?? false,
      iadeSozlesmesiOnayi: json['IadeSozlesmesiOnayi'] ?? false,
    );
  }
}

class Resim {
  final int id;
  final int urunId;
  final String resimAdi;
  final int siraNo;
  final int cdnServisSaglayiciId;
  final String resimUrl;

  Resim({
    required this.id,
    required this.urunId,
    required this.resimAdi,
    required this.siraNo,
    required this.cdnServisSaglayiciId,
    required this.resimUrl,
  });

  factory Resim.fromJson(Map<String, dynamic> json) {
    return Resim(
      id: json['Id'] ?? 0,
      urunId: json['UrunId'] ?? 0,
      resimAdi: json['ResimAdi'] ?? '',
      siraNo: json['SiraNo'] ?? 0,
      cdnServisSaglayiciId: json['CDNServisSaglayiciId'] ?? 0,
      resimUrl: json['ResimUrl'] ?? '',
    );
  }

  factory Resim.empty() {
    return Resim(
      id: 0,
      urunId: 0,
      resimAdi: '',
      siraNo: 0,
      cdnServisSaglayiciId: 0,
      resimUrl: '',
    );
  }
}

class OncekiIadeler {
  final int id;
  final bool aktifMi;
  final int faturaId;
  final int uyeId;
  final String iadeNo;
  final String fisNo;
  final String aciklama;
  final String personelAciklama;
  final DateTime? tamamlanmaTarihi;
  final int iadeDurumu;
  final double iadeTutar;
  final DateTime? kargoGelisTarihi;
  final DateTime? kargoGonderimTarihi;
  final String iadeCekKodu;
  final bool iadeSatirAktifMi;
  final int iadeId;
  final int faturaSatirId;
  final int iadeTurId;
  final int iadeTurNedenId;
  final int miktar;
  final double tutar;
  final bool paraIadesiYapildimi;
  final String responseMessage;

  OncekiIadeler({
    required this.id,
    required this.aktifMi,
    required this.faturaId,
    required this.uyeId,
    required this.iadeNo,
    required this.fisNo,
    required this.aciklama,
    required this.personelAciklama,
    this.tamamlanmaTarihi,
    required this.iadeDurumu,
    required this.iadeTutar,
    this.kargoGelisTarihi,
    this.kargoGonderimTarihi,
    required this.iadeCekKodu,
    required this.iadeSatirAktifMi,
    required this.iadeId,
    required this.faturaSatirId,
    required this.iadeTurId,
    required this.iadeTurNedenId,
    required this.miktar,
    required this.tutar,
    required this.paraIadesiYapildimi,
    required this.responseMessage,
  });

  factory OncekiIadeler.fromJson(Map<String, dynamic> json) {
    return OncekiIadeler(
      id: json['Id'] ?? 0,
      aktifMi: json['AktifMi'] ?? false,
      faturaId: json['FaturaId'] ?? 0,
      uyeId: json['UyeId'] ?? 0,
      iadeNo: json['IadeNo'] ?? '',
      fisNo: json['FisNo'] ?? '',
      aciklama: json['Aciklama'] ?? '',
      personelAciklama: json['PersonelAciklama'] ?? '',
      tamamlanmaTarihi: json['TamamlanmaTarihi'] != null
          ? DateTime.parse(json['TamamlanmaTarihi'])
          : null,
      iadeDurumu: json['IadeDurumu'] ?? 0,
      iadeTutar: json['IadeTutar']?.toDouble() ?? 0.0,
      kargoGelisTarihi: json['KargoGelisTarihi'] != null
          ? DateTime.parse(json['KargoGelisTarihi'])
          : null,
      kargoGonderimTarihi: json['KargoGonderimTarihi'] != null
          ? DateTime.parse(json['KargoGonderimTarihi'])
          : null,
      iadeCekKodu: json['IadeCekKodu'] ?? '',
      iadeSatirAktifMi: json['IadeSatirAktifMi'] ?? false,
      iadeId: json['IadeId'] ?? 0,
      faturaSatirId: json['FaturaSatirId'] ?? 0,
      iadeTurId: json['IadeTurId'] ?? 0,
      iadeTurNedenId: json['IadeTurNedenId'] ?? 0,
      miktar: json['Miktar'] ?? 0,
      tutar: json['Tutar']?.toDouble() ?? 0.0,
      paraIadesiYapildimi: json['ParaIadesiYapildimi'] ?? false,
      responseMessage: json['ResponseMessage'] ?? '',
    );
  }
}

class OdemeTur {
  final int id;
  final int siraNo;
  final String subeKodu;
  final String subeAdi;
  final String hesapNo;
  final String iban;
  final String xmlUrl;
  final String formPostUrl;
  final int tur;
  final double komisyon;
  final int komisyonTipi;
  final bool artiEksi;
  final double alisverisTutari;
  final double alisverisTutari1;
  final String logo;
  final int kargoId;
  final int sanalPosTur;
  final bool varsayilan;
  final String terminalID;
  final String mercantID;
  final String posNetID;
  final String encKey;
  final String firmNo;
  final String userID;
  final String password;
  final bool sanalPos3DZorunlu;
  final bool yayinDurumu;
  final bool aktifMi;
  final int sanalPosTuruEnum;
  final int girogateEnum;
  final int odemeTuruEnum;
  final int odemeTurKomisyonTipiEnum;
  final String adi;
  final String aciklama;
  final int siparisId;
  final int taksitSayisi;
  final double odemeKomisyonDoviz;
  final double amount;

  OdemeTur({
    required this.id,
    required this.siraNo,
    required this.subeKodu,
    required this.subeAdi,
    required this.hesapNo,
    required this.iban,
    required this.xmlUrl,
    required this.formPostUrl,
    required this.tur,
    required this.komisyon,
    required this.komisyonTipi,
    required this.artiEksi,
    required this.alisverisTutari,
    required this.alisverisTutari1,
    required this.logo,
    required this.kargoId,
    required this.sanalPosTur,
    required this.varsayilan,
    required this.terminalID,
    required this.mercantID,
    required this.posNetID,
    required this.encKey,
    required this.firmNo,
    required this.userID,
    required this.password,
    required this.sanalPos3DZorunlu,
    required this.yayinDurumu,
    required this.aktifMi,
    required this.sanalPosTuruEnum,
    required this.girogateEnum,
    required this.odemeTuruEnum,
    required this.odemeTurKomisyonTipiEnum,
    required this.adi,
    required this.aciklama,
    required this.siparisId,
    required this.taksitSayisi,
    required this.odemeKomisyonDoviz,
    required this.amount,
  });

  factory OdemeTur.fromJson(Map<String, dynamic> json) {
    return OdemeTur(
      id: json['Id'] ?? 0,
      siraNo: json['SiraNo'] ?? 0,
      subeKodu: json['SubeKodu'] ?? '',
      subeAdi: json['SubeAdi'] ?? '',
      hesapNo: json['HesapNo'] ?? '',
      iban: json['Iban'] ?? '',
      xmlUrl: json['XmlUrl'] ?? '',
      formPostUrl: json['FormPostUrl'] ?? '',
      tur: json['Tur'] ?? 0,
      komisyon: json['Komisyon']?.toDouble() ?? 0.0,
      komisyonTipi: json['KomisyonTipi'] ?? 0,
      artiEksi: json['ArtiEksi'] ?? false,
      alisverisTutari: json['AlisverisTutari']?.toDouble() ?? 0.0,
      alisverisTutari1: json['AlisverisTutari1']?.toDouble() ?? 0.0,
      logo: json['Logo'] ?? '',
      kargoId: json['KargoId'] ?? 0,
      sanalPosTur: json['SanalPosTur'] ?? 0,
      varsayilan: json['Varsayilan'] ?? false,
      terminalID: json['TerminalID'] ?? '',
      mercantID: json['MercantID'] ?? '',
      posNetID: json['PosNetID'] ?? '',
      encKey: json['EncKey'] ?? '',
      firmNo: json['FirmNo'] ?? '',
      userID: json['UserID'] ?? '',
      password: json['Password'] ?? '',
      sanalPos3DZorunlu: json['SanalPos3DZorunlu'] ?? false,
      yayinDurumu: json['YayinDurumu'] ?? false,
      aktifMi: json['AktifMi'] ?? false,
      sanalPosTuruEnum: json['SanalPosTuruEnum'] ?? 0,
      girogateEnum: json['GirogateEnum'] ?? 0,
      odemeTuruEnum: json['OdemeTuruEnum'] ?? 0,
      odemeTurKomisyonTipiEnum: json['OdemeTurKomisyonTipiEnum'] ?? 0,
      adi: json['Adi'] ?? '',
      aciklama: json['Aciklama'] ?? '',
      siparisId: json['SiparisId'] ?? 0,
      taksitSayisi: json['TaksitSayisi'] ?? 0,
      odemeKomisyonDoviz: json['OdemeKomisyonDoviz']?.toDouble() ?? 0.0,
      amount: json['Amount']?.toDouble() ?? 0.0,
    );
  }
}

class Sozlesme {
  final int id;
  final int siparisId;
  final int uyeId;
  final String satisSozlesmesi;
  final String onBilgilendirmeFormu;
  final bool aktifMi;

  Sozlesme({
    required this.id,
    required this.siparisId,
    required this.uyeId,
    required this.satisSozlesmesi,
    required this.onBilgilendirmeFormu,
    required this.aktifMi,
  });

  factory Sozlesme.fromJson(Map<String, dynamic> json) {
    return Sozlesme(
      id: json['Id'] ?? 0,
      siparisId: json['SiparisId'] ?? 0,
      uyeId: json['UyeId'] ?? 0,
      satisSozlesmesi: json['SatisSozlesmesi'] ?? '',
      onBilgilendirmeFormu: json['OnBilgilendirmeFormu'] ?? '',
      aktifMi: json['AktifMi'] ?? false,
    );
  }

  factory Sozlesme.empty() {
    return Sozlesme(
      id: 0,
      siparisId: 0,
      uyeId: 0,
      satisSozlesmesi: '',
      onBilgilendirmeFormu: '',
      aktifMi: false,
    );
  }
}
