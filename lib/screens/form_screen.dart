import 'package:arknights_gerenciador/components/event.dart';
import 'package:arknights_gerenciador/data/event_dao.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.eventContext}) : super(key: key);

  final BuildContext eventContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController originiteController = TextEditingController();
  TextEditingController skinsController = TextEditingController();
  TextEditingController skinsPricesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Novo Evento'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 650,
              width: 375,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //NOME DO EVENTO
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        validator: (String? value) {
                          if (valueValidator(value)) {
                            return 'Insira o nome do evento';
                          }
                          return null;
                        },
                        controller: nameController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'Nome do Evento',
                          filled: true,
                        )),
                  ),

                  //IMAGEM DO EVENTO
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (valueValidator(value)) {
                          return 'Insira um URL de Imagem!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                      controller: imageController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Imagem',
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.black),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        imageController.text,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset('assets/DIAMOND.webp');
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //ORIGINITE DO EVENTO
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            int.parse(value) < 0) {
                          return 'Insira uma quantidade válida de Originite Prime.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: originiteController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Originite',
                        filled: true,
                      ),
                    ),
                  ),

                  //SKINS
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            int.parse(value) < 0) {
                          return 'Insira uma quantidade de skins válida.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: skinsController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Quantidade de Skins',
                        filled: true,
                      ),
                    ),
                  ),

                  //PREÇO TOTAL DAS SKINS
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            int.parse(value) < 0) {
                          return 'Insira um valor total das skins válido.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: skinsPricesController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Valor das Skins',
                        filled: true,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        EventDao().save(
                          Event(
                            name: nameController.text,
                            image: imageController.text,
                            originite: int.parse(originiteController.text),
                            skins: int.parse(skinsController.text),
                            skinsPrices: int.parse(skinsPricesController.text),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Salvando novo Evento!'),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Adicionar!',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
