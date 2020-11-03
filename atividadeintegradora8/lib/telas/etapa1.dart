import 'package:atividadeintegradora8/custompaint.dart';
import 'package:atividadeintegradora8/models/relatorio.dart';
import 'package:atividadeintegradora8/telas/etapa2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Etapa1 extends StatefulWidget {
  bool checked1 = false;
  bool checked2 = false;
  bool checked3 = false;
  String uid;

  Etapa1(this.uid);

  @override
  _Etapa1State createState() => _Etapa1State();
}

class _Etapa1State extends State<Etapa1> {
  Relatorio relatorio = new Relatorio();

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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
            margin: EdgeInsets.only(left: leftRight, right: leftRight),
            child: _corpo(),
          ),
        ),
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
          "Já teve algum diagnóstico confirmado de Covid-19 ?",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        _check(),
        SizedBox(height: 50),
        Stack(
          children: [
            CustomPaint(
              painter: Fundo(),
            ),
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
        : (i == 2)
            ? value = widget.checked2
            : value = widget.checked3;

    return CheckboxListTile(
      activeColor: Color.fromRGBO(76, 64, 153, 1.0),
      controlAffinity: ListTileControlAffinity.leading,
      value: value,
      onChanged: (bool newValue) {
        setState(() {
          value = newValue;
          if (i == 1) {
            widget.checked1 = newValue;
            widget.checked2 = !newValue;
            widget.checked3 = !newValue;
          } else {
            if (i == 2) {
              widget.checked1 = !newValue;
              widget.checked2 = newValue;
              widget.checked3 = !newValue;
            } else {
              widget.checked1 = !newValue;
              widget.checked2 = !newValue;
              widget.checked3 = newValue;
            }
          }
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
        onPressed: () async {
          if (widget.checked2 == true) {
            await showDialog(
              context: (context),
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.deepOrange, width: 10),
                ),
                title: Text(
                    "Recomenda-se que você fique em casa por 14 dias após o diagnóstico da doença, período no qual você pode transmitir a doença para outras pessoas. Fique o tempo todo de máscara, mesmo dentro de casa, limpe as superfícies e lave as mão frequentemente e mantenha uma distância de 1,5 metro de outras pessoas sempre que possível. Mesmo depois de recuperado, você deve usar máscara quando sair de casa e manter o distanciamento social."),
              ),
            );
          }
          if (widget.checked1 == false &&
              widget.checked2 == false &&
              widget.checked3 == false) {
            showDialog(
              context: (context),
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.deepOrange, width: 10),
                ),
                title: Text("Selecione uma das opções"),
              ),
            );
          } else {
            await _update();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Etapa2(relatorio)));
          }
        },
      ),
    );
  }

  Future _update() {
    relatorio.uid = widget.uid;
    (widget.checked1 == true)
        ? relatorio.diagnostico = "Há mais de 15 dias"
        : (widget.checked2 == true)
            ? relatorio.diagnostico = "Há menos de 15 dias"
            : relatorio.diagnostico = "Nunca teve";
  }
}
