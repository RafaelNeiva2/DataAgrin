import 'package:farmweather/util/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import '../database/database.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}


class _CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _areaController = TextEditingController();

  DateTime? _selectedTime;

  @override
  void dispose() {
    _nameController.dispose();
    _areaController.dispose();
    super.dispose();
  }


  Future<void> _pickTime() async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Selecione a hora prevista',
    );

    if (timeOfDay != null) {
      setState(() {
        final now = DateTime.now();
        _selectedTime = DateTime(
          now.year,
          now.month,
          now.day,
          timeOfDay.hour,
          timeOfDay.minute,
        );
      });
    }
  }

  void _saveTask() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid) {
      return;
    }


    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione uma hora para a tarefa.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }


    final db = Provider.of<AppDatabase>(context, listen: false);


    final novaTarefa = TarefasCompanion(
      nome: drift.Value(_nameController.text),
      talhao: drift.Value(_areaController.text),
      horaPrevista: drift.Value(_selectedTime!),
      status: const drift.Value(Status.pendente),
    );


    db.addTarefa(novaTarefa).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarefa salva com sucesso!')),
      );
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $error')),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(showBackButton: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome da Tarefa',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.task_alt),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome da tarefa.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),


                TextFormField(
                  controller: _areaController,
                  decoration: const InputDecoration(
                    labelText: 'Área / Talhão',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on_outlined),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a área ou talhão.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.access_time_filled_rounded, color: Colors.grey),
                  title: const Text('Hora Prevista'),
                  subtitle: Text(
                    _selectedTime == null
                        ? 'Nenhuma hora selecionada'
                        : DateFormat.Hm().format(_selectedTime!),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _selectedTime != null ? Theme.of(context).primaryColor : Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  onTap: _pickTime,
                ),

                const SizedBox(height: 32),

                Center(
                  child: ElevatedButton.icon(
                    onPressed: _saveTask,
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar Tarefa'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: const Color(0xFFFFC900),
                      foregroundColor: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}