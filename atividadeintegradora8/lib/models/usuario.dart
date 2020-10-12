import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String nome;
  String email;
  String dataNasc;
  bool sexo;
  String telefone;
  String curso;
  String matricula;
  int periodo;
  //ENDEREÇO
  String estado;
  String cidade;
  String bairro;
  String rua;
  String ncasa;
  String cep;
  String uid;

  DocumentReference reference;

  Usuario({
    this.nome,
    this.email,
    this.dataNasc,
    this.sexo,
    this.telefone,
    this.curso,
    this.matricula,
    this.periodo,
    this.estado,
    this.cidade,
    this.bairro,
    this.rua,
    this.ncasa,
    this.cep,
    this.uid
  });

  factory Usuario.fromSnapshot(DocumentSnapshot snapshot){
    Usuario novoAluno = Usuario.fromJson(snapshot.data);
    novoAluno.reference = snapshot.reference;
    return novoAluno;
  }

  factory Usuario.fromJson(Map<dynamic, dynamic> json) => _UsuarioFromJson(json);

  Map<String, dynamic> toJson() => _UsuarioToJson(this);
}

Usuario _UsuarioFromJson(Map<dynamic, dynamic> json){
  return Usuario(
    nome: json['nome'] as String,
    email: json['email'] as String,
    dataNasc: json['dataNasc'] as String,
    sexo: json['sexo'] as bool,
    telefone: json['telefone'] as String,
    curso: json['curso'] as String,
    matricula: json['matricula'] as String,
    periodo: json['periodo'] as int,
    estado: json['estado'] as String,
    cidade: json['cidade'] as String,
    bairro: json['bairro'] as String,
    rua: json['rua'] as String,
    ncasa: json['ncasa'] as String,
    cep: json['cep'] as String,
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _UsuarioToJson(Usuario instance) => <String, dynamic>{
  'nome': instance.nome,
  'email': instance.email,
  'dataNasc': instance.dataNasc,
  'sexo': instance.sexo,
  'telefone': instance.telefone,
  'curso': instance.curso,
  'matricula': instance.matricula,
  'periodo': instance.periodo,
  'estado': instance.estado,
  'cidade': instance.cidade,
  'bairro': instance.bairro,
  'rua': instance.rua,
  'ncasa': instance.ncasa,
  'cep': instance.cep,
  'uid': instance.uid,
};