import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String nome;
  String email;
  int idade;
  String curso;
  String matricula;
  int periodo;
  //ENDEREÇO
  String estado;
  String cidade;
  String bairro;
  String uid;

  DocumentReference reference;

  Usuario({
    this.nome,
    this.email,
    this.idade,
    this.curso,
    this.matricula,
    this.periodo,
    this.estado,
    this.cidade,
    this.bairro,
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
    idade: json['idade'] as int,
    curso: json['curso'] as String,
    matricula: json['matricula'] as String,
    periodo: json['periodo'] as int,
    estado: json['estado'] as String,
    cidade: json['cidade'] as String,
    bairro: json['bairro'] as String,
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _UsuarioToJson(Usuario instance) => <String, dynamic>{
  'nome': instance.nome,
  'email': instance.email,
  'idade': instance.idade,
  'curso': instance.curso,
  'matricula': instance.matricula,
  'periodo': instance.periodo,
  'estado': instance.estado,
  'cidade': instance.cidade,
  'bairro': instance.bairro,
  'uid': instance.uid,
};