import 'package:cloud_firestore/cloud_firestore.dart';

class Relatorio {
  String diagnostico;
  String data;
  List<String> sintomas;
  bool moraOuTrabalha;
  String uid;

  DocumentReference reference;

  Relatorio(
      {this.diagnostico,
      this.data,
      this.sintomas,
      this.moraOuTrabalha,
      this.uid});

  factory Relatorio.fromSnapshot(DocumentSnapshot snapshot) {
    Relatorio novoRelatorio = Relatorio.fromJson(snapshot.data);
    novoRelatorio.reference = snapshot.reference;
    return novoRelatorio;
  }

  factory Relatorio.fromJson(Map<dynamic, dynamic> json) =>
      _RelatorioFromJson(json);

  Map<String, dynamic> toJson() => _RelatorioToJson(this);
}

Relatorio _RelatorioFromJson(Map<dynamic, dynamic> json) {
  return Relatorio(
    diagnostico: json['diagnostico'] as String,
    data: json['data'] as String,
    sintomas: json['sintomas'] as List<String>,
    moraOuTrabalha: json['moraOuTrabalha'] as bool,
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _RelatorioToJson(Relatorio instance) => <String, dynamic>{
  'diagnostico': instance.diagnostico,
  'data': instance.data,
  'sintomas': instance.sintomas,
  'moraOuTrabalha': instance.moraOuTrabalha,
  'uid': instance.uid,
};