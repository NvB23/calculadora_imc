import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Calculadora de IMC",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: _resetAll,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 3),
                      borderRadius: BorderRadius.circular(70)),
                  child: const Icon(
                    Icons.people,
                    color: Colors.green,
                    size: 100,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: weightController,
                  decoration: const InputDecoration(
                    labelText: "Peso",
                    labelStyle: TextStyle(color: Colors.green),
                    suffix: Text(
                      "Kg",
                      style: TextStyle(color: Colors.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                    )
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Insira seu Peso.";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: heightController,
                  decoration: const InputDecoration(
                    labelText: "Altura",
                    labelStyle: TextStyle(color: Colors.green),
                    suffix: Text(
                      "cm",
                      style: TextStyle(color: Colors.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      )
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Insira sua Altura.";
                    }
                    if (value.contains(",")) {
                      return "Coloque em cm.";
                    }
                    return null;
                  }
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){
                          final form = _formKey.currentState;
                          if (form != null && form.validate()){
                            _calculate();
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.green),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)))),
                        child: const Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                ),
                Text(
                  _infoText,
                  style: const TextStyle(fontSize: 25),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resetAll() {
    setState(() {
      heightController.clear();
      weightController.clear();
      _formKey.currentState?.reset();
      _infoText = "Informe seus dados";
    });
  }

  void _calculate() {
    double height = double.parse(heightController.text) / 100;
    double weight = 0;

    String weightString = weightController.text;
    if (weightString.contains(",")) {
      int weightIndex = weightString.indexOf(",");
      String replaceWeight = weightString.replaceRange(weightIndex, weightIndex + 1, ".");
      weight = double.parse(replaceWeight);
    } else {
      weight = double.parse(weightString);
    }

    double imc = weight / (height * height);

    setState(() {
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }
}
