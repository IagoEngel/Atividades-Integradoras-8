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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Container(
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
                SizedBox(height: 30)
              ],
            ),
          ),
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
        autofocus: true,
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cadastro()));
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

          if (_getEmailValido(txtController.text)) {
            await showDialog(
              context: (context),
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                      color: Color.fromRGBO(17, 0, 119, 1.0), width: 5),
                ),
                title: Text("Email inexistente"),
              ),
            );
          } else if (txtController.text.isNotEmpty &&
              txtSenha.text.isNotEmpty &&
              result != null) {
            Usuario usuario = new Usuario();
            await _getUsuario(result.uid).then((QuerySnapshot docs) {
              usuario.nome = docs.documents[0].data['nome'];
              usuario.email = docs.documents[0].data['email'];
              usuario.idade = docs.documents[0].data['idade'];
              usuario.curso = docs.documents[0].data['curso'];
              usuario.matricula = docs.documents[0].data['matricula'];
              usuario.periodo = docs.documents[0].data['periodo'];
              usuario.estado = docs.documents[0].data['estado'];
              usuario.cidade = docs.documents[0].data['cidade'];
              usuario.bairro = docs.documents[0].data['bairro'];
              usuario.uid = docs.documents[0].data['uid'];
            });
            await _verificarRelatorioExistente(usuario.uid).then(
              (QuerySnapshot docs) {
                String dataAtual = DateTime.now().day.toString() +
                    "/" +
                    DateTime.now().month.toString() +
                    "/" +
                    DateTime.now().year.toString();
                (docs.documents.isEmpty)
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Etapa1(usuario.uid)))
                    : print("CATINGAS");
                docs.documents.forEach((element) {
                  if (element.data['data'] == dataAtual) {
                    showDialog(
                      context: (context),
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                              color: Color.fromRGBO(17, 0, 119, 1.0), width: 5),
                        ),
                        title: Text(
                          "Relatório de $dataAtual já preenchido",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Etapa1(usuario.uid)));
                  }
                });
              },
            );
            await _auth.signOff();
          } else {
            showDialog(
                context: (context),
                builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                            color: Color.fromRGBO(17, 0, 119, 1.0), width: 5),
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

  _getEmailValido(String email) {
    var aux = Firestore.instance
        .collection('usuario')
        .where('email', isEqualTo: email)
        .getDocuments();
    if (aux == null)
      return true;
    else
      return false;
  }

  _verificarRelatorioExistente(String uid) {
    return Firestore.instance
        .collection('relatorio')
        .where('uid', isEqualTo: uid)
        .getDocuments();
  }
}
