import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para inserir dados em uma coleção específica
  Future<void> inserirDados(String collectionPath, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).add(data);
      print('Dados inseridos com sucesso!');
    } catch (e) {
      print('Erro ao inserir dados: $e');
    }
  }
}
