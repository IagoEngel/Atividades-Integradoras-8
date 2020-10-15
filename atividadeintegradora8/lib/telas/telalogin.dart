import 'package:atividadeintegradora8/models/usuario.dart';
import 'package:atividadeintegradora8/services/auth.dart';
import 'package:atividadeintegradora8/telas/cadastro.dart';
import 'package:atividadeintegradora8/telas/etapa1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final AuthService _auth = AuthService();
  TextEditingController txtController = new TextEditingController();
  TextEditingController txtSenha = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromRGBO(17, 0, 119, 1.0),
              Color.fromRGBO(166, 160, 204, 1.0),
            ])),
        child: Column(
          children: [
            SizedBox(height: 25),
            Image.asset(
              "assets/images/unifenasLOGO1.png",
              height: 120,
              width: 120,
            ),
            SizedBox(height: 30),
            _textoCovid(),
            _textFields(),
            SizedBox(height: 80),
            _botaoCriarConta(),
            SizedBox(height: 5),
            _botaoEntrar(),
            Container(height: 0),
          ],
        ),
      ),
    );
  }

  Widget _textoCovid() {
    return Stack(
      children: [
        Text(
          "Controle de Covid - 19",
          style: TextStyle(
            fontSize: 35,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5
              ..color = Colors.white,
          ),
        ),
        Text(
          "Controle de Covid - 19",
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _campoAtributo(var campoController) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      width: MediaQuery.of(context).size.width * 0.8138,
      child: TextField(
        controller: campoController,
        obscureText: (campoController == txtSenha) ? true : false,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white),
          ),
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _textFields() {
    return Column(
      children: [
        SizedBox(height: 100),
        Text(
          "Digite seu email",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        SizedBox(height: 15),
        _campoAtributo(txtController),
        SizedBox(height: 30),
        Text(
          "Digite sua senha",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        SizedBox(height: 15),
        _campoAtributo(txtSenha),
      ],
    );
  }

  Widget _botaoCriarConta() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.0718,
      width: MediaQuery.of(context).size.width * 0.475,
      child: RaisedButton(
        color: Color.fromRGBO(76, 64, 153, 1.0),
        textColor: Colors.white,
        splashColor: Colors.white12,
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Text("Crie sua conta", style: TextStyle(fontSize: 23)),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro()));
        },
      ),
    );
  }

  Widget _botaoEntrar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.0718,
      width: MediaQuery.of(context).size.width * 0.475,
      child: RaisedButton(
        color: Color.fromRGBO(76, 64, 153, 1.0),
        textColor: Colors.white,
        splashColor: Colors.white12,
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Text("Entrar", style: TextStyle(fontSize: 23)),
        onPressed: () async {
          dynamic result =
              await _auth.signInEmailPasswd(txtController.text, txtSenha.text);
          if (txtController.text.isNotEmpty &&
              txtSenha.text.isNotEmpty &&
              result != null) {
            Usuario usuario = new Usuario();
            await _getUsuario(result.uid).then((QuerySnapshot docs) {
              usuario.nome = docs.documents[0].data['nome'];
              usuario.email = docs.documents[0].data['email'];
              usuario.dataNasc = docs.documents[0].data['dataNasc'];
              usuario.sexo = docs.documents[0].data['sexo'];
              usuario.telefone = docs.documents[0].data['telefone'];
              usuario.curso = docs.documents[0].data['curso'];
              usuario.matricula = docs.documents[0].data['matricula'];
              usuario.periodo = docs.documents[0].data['periodo'];
              usuario.estado = docs.documents[0].data['estado'];
              usuario.cidade = docs.documents[0].data['cidade'];
              usuario.bairro = docs.documents[0].data['bairro'];
              usuario.rua = docs.documents[0].data['rua'];
              usuario.ncasa = docs.documents[0].data['ncasa'];
              usuario.cep = docs.documents[0].data['cep'];
              usuario.uid = docs.documents[0].data['uid'];
            });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Etapa1()));
          } else {
            showDialog(
                context: (context),
                builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.deepOrange, width: 10),
                      ),
                      title: Text("Preencha os campos de matrícula e senha !"),
                    ));
          }
        },
      ),
    );
  }

  _getUsuario(String uid) {
    return Firestore.instance
        .collection('usuario')
        .where('uid', isEqualTo: uid)
        .getDocuments();
  }
}
