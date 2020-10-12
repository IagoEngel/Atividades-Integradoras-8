import 'package:atividadeintegradora8/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioRepository{

  CollectionReference collection = Firestore.instance.collection('usuario');

  Stream<QuerySnapshot> getStream(){
    return collection.snapshots();
  }

  Future<DocumentReference> addUsuario(Usuario usuario){
    return collection.add(usuario.toJson());
  }

  updateUsuario(Usuario usuario) async {
    await collection.document(usuario.reference.documentID).updateData(usuario.toJson());
  }

}