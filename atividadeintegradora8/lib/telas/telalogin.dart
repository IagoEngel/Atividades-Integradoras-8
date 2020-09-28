import 'package:atividadeintegradora8/telas/etapa1.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController txtController = new TextEditingController();
  TextEditingController txtSenha = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 100,
              width: 100,
            ),
            SizedBox(height: 30),
            _textoCovid(),
            _textFields(),
            SizedBox(height: 80),
            _botaoCriarConta(),
            SizedBox(height: 5),
            _botaoEntrar(),
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
        style: TextStyle(),
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
          "Digite sua Matrícula",
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
        onPressed: () {},
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Etapa1()));
        },
      ),
    );
  }
}
