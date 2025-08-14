import 'package:farmweather/pages/weather_page.dart';
import 'package:farmweather/util/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import 'package:drift/drift.dart' as drift;
import '../util/bottom_nav_bar.dart';
import '../util/custom_classes.dart';
import 'createtask_page.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  void _onNavBarTap(int index) {
    if (index == 0) return;
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WeatherPage()),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomNavBar(
      currentIndex: 0,
      onTap: _onNavBarTap,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    hintText: "Pesquise uma tarefa...",
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    icon: Icons.search,
                    colorIcon: Colors.grey,
                    width: double.infinity,
                    height: 49,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateTaskPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Tarefa>>(
              stream: db.watchAllTarefas(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final tarefas = snapshot.data!;

                if (tarefas.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhuma tarefa para hoje.\nAdicione uma nova no botão "+".',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                final filteredTarefas = tarefas.where((tarefa) {
                  final nomeLower = tarefa.nome.toLowerCase();
                  final talhaoLower = tarefa.talhao.toLowerCase();
                  final queryLower = _searchQuery.toLowerCase();
                  return nomeLower.contains(queryLower) ||
                      talhaoLower.contains(queryLower);
                }).toList();

                if (filteredTarefas.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhuma tarefa encontrada.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: filteredTarefas.length,
                  itemBuilder: (context, index) {
                    final tarefa = filteredTarefas[index];
                    return TaskCard(tarefa: tarefa);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Tarefa tarefa;
  const TaskCard({super.key, required this.tarefa});

  Color _getStatusColor(Status status) {
    switch (status) {
      case Status.pendente:
        return Colors.orangeAccent;
      case Status.emAndamento:
        return Colors.blueAccent;
      case Status.finalizada:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(Status status) {
    switch (status) {
      case Status.pendente:
        return 'Pendente';
      case Status.emAndamento:
        return 'Em Andamento';
      case Status.finalizada:
        return 'Finalizada';
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final statusColor = _getStatusColor(tarefa.status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 8,
                color: statusColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tarefa.nome,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                          Icons.location_on_outlined, 'Área: ${tarefa.talhao}'),
                      const SizedBox(height: 6),
                      _buildInfoRow(Icons.access_time_filled_rounded,
                          'Previsto: ${DateFormat.Hm().format(tarefa.horaPrevista)}'),
                      const Spacer(),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _buildStatusDropdown(context, db, statusColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 18),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(fontSize: 15, color: Color(0xFF555555))),
      ],
    );
  }

  Widget _buildStatusDropdown(
      BuildContext context, AppDatabase db, Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButton<Status>(
        value: tarefa.status,
        onChanged: (newStatus) {
          if (newStatus != null) {
            final updatedTarefa =
            tarefa.toCompanion(true).copyWith(
              status: drift.Value(newStatus),
            );
            db.updateTarefa(updatedTarefa);
          }
        },
        underline: Container(),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: statusColor,
        ),
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        items: Status.values.map((status) {
          return DropdownMenuItem(
            value: status,
            child: Text(
              _getStatusText(status),
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}