import 'package:cloud_firestore/cloud_firestore.dart';

class Satis {
  List<SatisUrun> urunler;
  bool satisUrunDurumu;
  DateTime satisZamani;
  DocumentReference userRef;
  DocumentReference? reference;

  Satis({
    required this.urunler,
    required this.satisUrunDurumu,
    required this.satisZamani,
    required this.userRef,
  });

  Satis.fromMap(DocumentSnapshot doc, {required this.reference})
      : assert(doc['urunler'] != null),
        assert(doc['user_ref'] != null),
        assert(doc["satis_urun_durumu"] != null),
        assert(doc["satis_zamani"] != null),
        urunler =
            doc['urunler'].map<SatisUrun>((e) => SatisUrun.fromMap(e)).toList(),
        satisUrunDurumu = doc["satis_urun_durumu"],
        satisZamani = DateTime.fromMillisecondsSinceEpoch(
            doc["satis_zamani"].seconds * 1000),
        userRef = doc['user_ref'];

  Satis.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot,
          reference: snapshot.reference,
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['urunler'] = this.urunler.map((e) => e.toJson()).toList();
    data['satis_urun_durumu'] = this.satisUrunDurumu;
    data['satis_zamani'] = this.satisZamani;
    data['user_ref'] = this.userRef;
    return data;
  }
}

class SatisUrun {
  int satisUrunAdet;
  DocumentReference satisUrunRef;

  SatisUrun({
    required this.satisUrunAdet,
    required this.satisUrunRef,
  });

  SatisUrun.fromMap(Map<String, dynamic> doc)
      : assert(doc["satis_urun_adet"] != null),
        assert(doc["satis_urun_ref"] != null),
        satisUrunAdet = doc["satis_urun_adet"],
        satisUrunRef = doc["satis_urun_ref"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['satis_urun_adet'] = this.satisUrunAdet;
    data['satis_urun_ref'] = this.satisUrunRef;
    return data;
  }
}
