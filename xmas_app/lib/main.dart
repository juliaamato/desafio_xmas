import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MaterialApp(home: XmasCounter()));
}

class XmasCounter extends StatefulWidget {
  const XmasCounter({super.key});

  @override
  State<XmasCounter> createState() => _XmasCounterState();
}

class _XmasCounterState extends State<XmasCounter> {
  int? total;

  @override
  void initState() {
    super.initState();
    _contarXmas();
  }

  Future<void> _contarXmas() async {
    final input = await rootBundle.loadString('assets/input.txt');
    final lines = input.split('\n').map((e) => e.trim()).toList();
    final count = contarXMAS(lines);
    setState(() {
      total = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contador de XMAS")),
      body: Center(
        child: total == null
            ? const CircularProgressIndicator()
            : Text(
                "Total de XMAS encontrados: $total",
                style: const TextStyle(fontSize: 20),
              ),
      ),
    );
  }
}

int contarXMAS(List<String> grid) {
  const word = "XMAS";
  final directions = [
    [0, 1], [1, 0], [1, 1], [-1, -1],
    [0, -1], [-1, 0], [-1, 1], [1, -1]
  ];
  final rows = grid.length;
  final cols = grid[0].length;
  int count = 0;

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      for (var dir in directions) {
        bool found = true;
        for (int k = 0; k < word.length; k++) {
          int ni = i + dir[0] * k;
          int nj = j + dir[1] * k;
          if (ni < 0 || nj < 0 || ni >= rows || nj >= cols || grid[ni][nj] != word[k]) {
            found = false;
            break;
          }
        }
        if (found) count++;
      }
    }
  }

  return count;
}