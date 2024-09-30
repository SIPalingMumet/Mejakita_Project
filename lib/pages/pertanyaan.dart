import 'package:flutter/material.dart';

class Pertanyaan extends StatefulWidget {
  const Pertanyaan({super.key});

  @override
  State<Pertanyaan> createState() => _PertanyaanState();
}

class _PertanyaanState extends State<Pertanyaan> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pilih bidang yang kamu kuasai!",
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/homepage');
                  },
                  child: const Text(
                    'LEWATI',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/homepage');
                  },
                  child: const Text(
                    'SIMPAN',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          buildOptionItem('[English] Pengetahuan Umum', Icons.language, 'english'),
          buildOptionItem('Pengetahuan Kuantitatif', Icons.calculate, 'kuantitatif'),
        ],
      ),
    );
  }

  Widget buildOptionItem(String title, IconData icon, String value) {
    bool isSelected = selectedOption == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
              color: isSelected ? Colors.purple : Colors.grey,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.purple : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.purple,
              ),
          ],
        ),
      ),
    );
  }
}
