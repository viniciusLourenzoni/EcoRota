import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FuelEntryForm extends StatefulWidget {
  const FuelEntryForm({super.key});

  @override
  State<FuelEntryForm> createState() => _FuelEntryFormState();
}

class _FuelEntryFormState extends State<FuelEntryForm> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController(
    text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
  );
  final _litersController = TextEditingController();
  final _priceController = TextEditingController();
  final _odometerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Data',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  _dateController.text = DateFormat('dd/MM/yyyy').format(date);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _litersController,
              decoration: const InputDecoration(
                labelText: 'Litros',
                prefixIcon: Icon(Icons.local_gas_station),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a quantidade de litros';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Preço por litro',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o preço';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _odometerController,
              decoration: const InputDecoration(
                labelText: 'Quilometragem',
                prefixIcon: Icon(Icons.speed),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a quilometragem';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: Salvar o registro de abastecimento
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar Abastecimento'),
            ),
          ],
        ),
      ),
    );
  }
}