import 'package:atividadeintegradora8/custompaint.dart';
import 'package:flutter/material.dart';

class Etapa1 extends StatefulWidget {
  bool checked1 = false;
  bool checked2 = false;
  bool checked3 = false;
  @override
  _Etapa1State createState() => _Etapa1State();
}

class _Etapa1State extends State<Etapa1> {
  @override
  Widget build(BuildContext context) {
    double leftRight = MediaQuery.of(context).size.width * 0.0444;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(17, 0, 119, 1.0),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1171,
        leadingWidth: 70,
        leading: Image.asset(
          'assets/images/unifenasLOGO1.png',
        ),
        title: _textoCovid(),
      ),
      body: Container(
        margin: EdgeInsets.only(left: leftRight, right: leftRight),
        child: _corpo(),
      ),
    );
  }

  Widget _textoCovid() {
    return Stack(
      children: [
        Text(
          "Controle Covid - 19",
          style: TextStyle(
            fontSize: 30,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5
              ..color = Colors.white,
          ),
        ),
        Text(
          "Controle Covid - 19",
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }

  Widget _corpo() {
    double heightContainer = MediaQuery.of(context).size.height * 0.0375;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: heightContainer,
          decoration: BoxDecoration(
              color: Color.fromRGBO(106, 96, 170, 1.0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )),
          child: Text(
            "Etapa 1",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        SizedBox(height: 250),
        Text(
          "Já teve algum diagnóstico confirmado de Covid-19:",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        _check(),
        SizedBox(height: 50),
        Stack(
          children: [
            CustomPaint(painter: Fundo(),),
            _botaoProximo(),
          ],
        ),
      ],
    );
  }

  Widget _check() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              offset: Offset(0.3, 1.0),
              blurRadius: 4,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.25)),
        ],
      ),
      child: Column(
        children: [
          _checkBoxListTile(1, "Há mais de 15 dias"),
          _checkBoxListTile(2, "Há menos de 15 dias"),
          _checkBoxListTile(3, "Nunca teve"),
        ],
      ),
    );
  }

  Widget _checkBoxListTile(int i, String txt) {
    bool value;
    (i == 1)
        ? value = widget.checked1
        : (i == 2) ? value = widget.checked2 : value = widget.checked3;

    return CheckboxListTile(
      activeColor: Color.fromRGBO(76, 64, 153, 1.0),
      controlAffinity: ListTileControlAffinity.leading,
      value: value,
      onChanged: (bool newValue) {
        setState(() {
          value = newValue;
          (i == 1)
              ? widget.checked1 = value
              : (i == 2)
                  ? widget.checked2 = newValue
                  : widget.checked3 = newValue;
        });
      },
      title: Text(
        "$txt",
        style: TextStyle(fontSize: 17),
      ),
    );
  }

  Widget _botaoProximo() {
    return Container(
      width: 250,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 0,
            spreadRadius: 3,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: FlatButton(
        color: Color.fromRGBO(76, 64, 153, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 30),
            Text(
              "Próxima etapa",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 20),
            Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
