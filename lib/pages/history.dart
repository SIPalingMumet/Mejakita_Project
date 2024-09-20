import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'jawaban.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Box box; 

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    box = Hive.box('savedDataBox'); 
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus item ini?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              hapusSoal(index);  
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void hapusSoal(int index) {
    setState(() {
      box.deleteAt(index); 
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item berhasil dihapus')),
    );
  }

  Widget buildSoalList() {
    if (box.isEmpty) {
      return const Center(
        child: Text('Belum ada soal yang diunggah'),
      );
    }

    return ListView.builder(
      itemCount: box.length,
      itemBuilder: (context, index) {
        final soalData = box.getAt(index) as Map;

        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(soalData['text'] ?? 'No Text Available'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                soalData['imagePath'] != null
                    ? Image.file(
                        File(soalData['imagePath']),
                        height: 150,
                        width: 110,
                        fit: BoxFit.cover,
                      )
                    : const Text('No Image Available'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Align to left
                  children: [
                    ElevatedButton(
                      onPressed: () => confirmDelete(index),
                      child: const Text('Hapus'),
                    ),
                    const Spacer(), // Push other content to the right (if any)
                  ],
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    index: index,
                    questionData: soalData,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildAnsweredSoalList() {
    final List<Map> answeredSoals = [];

    for (int i = 0; i < box.length; i++) {
      final soalData = box.getAt(i) as Map;
      if (soalData['answers'] != null && (soalData['answers'] as List).isNotEmpty) {
        answeredSoals.add(soalData);
      }
    }

    if (answeredSoals.isEmpty) {
      return const Center(
        child: Text('Belum ada jawaban'),
      );
    }

    return ListView.builder(
      itemCount: answeredSoals.length,
      itemBuilder: (context, index) {
        final soalData = answeredSoals[index];

        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(soalData['text'] ?? 'No Text Available'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jumlah Jawaban: ${(soalData['answers'] as List).length}'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Align to left
                  children: [
                    ElevatedButton(
                      onPressed: () => confirmDelete(box.values.toList().indexOf(soalData)),
                      child: const Text('Hapus'),
                    ),
                    const Spacer(), // Pushes other content to the right if needed
                  ],
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    index: box.values.toList().indexOf(soalData),
                    questionData: soalData,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("History Diskusi PR"),
        backgroundColor: Colors.white,
        elevation: 1, 
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black, 
          tabs: const [
            Tab(text: 'Pertanyaan'),
            Tab(text: 'Jawaban'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, Box box, _) {
              return buildSoalList(); 
            },
          ),
          ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, Box box, _) {
              return buildAnsweredSoalList(); 
            },
          ),
        ],
      ),
    );
  }
}
