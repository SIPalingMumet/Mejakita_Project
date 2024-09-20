import 'package:flutter/material.dart';

class Pertanyaan extends StatefulWidget {
  const Pertanyaan({super.key});

  @override
  State<Pertanyaan> createState() => _PertanyaanState();
}

class _PertanyaanState extends State<Pertanyaan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Flexible(
          child: Text(
            "Pilihlah Bidang Yang Kamu Kuasai !",
            style: TextStyle(fontFamily: 'Lato', fontSize: 19),
            maxLines: 2, // Menentukan maksimal 2 baris
            overflow: TextOverflow.ellipsis, // Memotong teks jika terlalu panjang
          ),
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
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/homepage');
                  },
                  child: const Text(
                    'SIMPAN',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text("Isi halaman pertanyaan di sini"),
      ),
    );
  }
}