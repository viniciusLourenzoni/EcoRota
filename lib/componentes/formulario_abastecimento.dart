import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/abastecimento_model.dart';
import '../services/abastecimento_service.dart';

class FormularioAbastecimento extends StatefulWidget {
  const FormularioAbastecimento({super.key});

  @override
  State<FormularioAbastecimento> createState() => _FormularioAbastecimentoState();
}

class _FormularioAbastecimentoState extends State<FormularioAbastecimento> {
  final _chaveFormulario = GlobalKey<FormState>();
  final _dataController = TextEditingController(
    text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
  );
  final _litrosController = TextEditingController();
  final _precoController = TextEditingController();
  final _odometroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _chaveFormulario,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _dataController,
              decoration: const InputDecoration(
                labelText: 'Data',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                final data = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (data != null) {
                  _dataController.text = DateFormat('dd/MM/yyyy').format(data);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _litrosController,
              decoration: const InputDecoration(
                labelText: 'Litros',
                prefixIcon: Icon(Icons.local_gas_station),
              ),
              keyboardType: TextInputType.number,
              validator: (valor) {
                if (valor == null || valor.isEmpty) {
                  return 'Por favor, insira a quantidade de litros';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _precoController,
              decoration: const InputDecoration(
                labelText: 'Preço por litro',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              validator: (valor) {
                if (valor == null || valor.isEmpty) {
                  return 'Por favor, insira o preço';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _odometroController,
              decoration: const InputDecoration(
                labelText: 'Quilometragem',
                prefixIcon: Icon(Icons.speed),
              ),
              keyboardType: TextInputType.number,
              validator: (valor) {
                if (valor == null || valor.isEmpty) {
                  return 'Por favor, insira a quilometragem';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (!_chaveFormulario.currentState!.validate()) return;
                  final novo = AbastecimentoModel(
                    data: _dataController.text,
                    litros: double.parse(_litrosController.text),
                    preco: double.parse(_precoController.text),
                    odometro: int.parse(_odometroController.text),
                    posto: 'Posto Manual',
                  );
                  await AbastecimentoService().inserir(novo);
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
              },
              child: const Text('Salvar Abastecimento'),
            ),
          ],
        ),
      ),
    );
  }
}
