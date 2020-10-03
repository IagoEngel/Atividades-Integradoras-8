import 'package:atividadeintegradora8/custompaint.dart';
import 'package:atividadeintegradora8/telas/etapa3.dart';
import 'package:flutter/material.dart';

class Etapa2 extends StatefulWidget {
  bool checked1 = false;
  bool checked2 = false;
  bool checked3 = false;
  bool checked4 = false;
  bool checked5 = false;
  bool checked6 = false;
  bool checked7 = false;
  int sintomas = 0;
  @override
  _Etapa2State createState() => _Etapa2State();
}

class _Etapa2State extends State<Etapa2> {
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
            "Etapa 2",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        SizedBox(height: 250),
        Text(
          "Apresenta algum dos sintomas abaixo ?",
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
          _checkBoxListTile(1, "Febre"),
          _checkBoxListTile(2, "Alteração no paladar"),
          _checkBoxListTile(3, "Alteração no olfato"),
          _checkBoxListTile(4, "Falta de ar ou dificuldade para respirar"),
          _checkBoxListTile(5, "Dor de garganta"),
          _checkBoxListTile(6, "Diarreia"),
          _checkBoxListTile(7, "Dor de cabeça"),
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
            : (i == 3)
                ? value = widget.checked3
                : (i == 4)
                    ? value = widget.checked4
                    : (i == 5)
                        ? value = widget.checked5
                        : (i == 6)
                            ? value = widget.checked6
                            : value = widget.checked7;

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
                  : (i == 3)
                      ? widget.checked3 = newValue
                      : (i == 4)
                          ? widget.checked4 = newValue
                          : (i == 5)
                              ? widget.checked5 = newValue
                              : (i == 6)
                                  ? widget.checked6 = newValue
                                  : widget.checked7 = newValue;

          (value == false) ? widget.sintomas = 0 : widget.sintomas = 1;
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
          if (widget.sintomas == 1) {
            await showDialog(
              context: (context),
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.deepOrange, width: 10),
                ),
                title: Text(
                    "A presença de um ou mais dessas manifestações pode indicar que você tem alguma doença respiratória que pode ser transmitida para outras pessoas, como a covid-19. Se estiver doente, você pode transmitir sua doença para outras pessoas. Recomenda-se que você máscara, mantenha o distanciamento social e procure atendimento médico o mais breve possível."),
              ),
            );
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Etapa3()));
        },
      ),
    );
  }
}
