import 'package:atividadeintegradora8/models/relatorio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RelatorioRepository{

  CollectionReference collection = Firestore.instance.collection('relatorio');

  Stream<QuerySnapshot> getStream(){
    return collection.snapshots();
  }

  Future<DocumentReference> addRelatorio(Relatorio relatorio){
    return collection.add(relatorio.toJson());
  }

  updateRelatorio(Relatorio relatorio) async{
    await collection.document(relatorio.reference.documentID).updateData(relatorio.toJson());
  }

}