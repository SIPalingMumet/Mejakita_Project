import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'jawaban.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final picker = ImagePicker();
  final tSoal = TextEditingController();
  late Box box;
  String selectedTag = '';
  String filterTag = '';
  String activeFilter = 'Semua';

  @override
  void initState() {
    super.initState();
    box = Hive.box('savedDataBox');
  }

  void pilihFoto(Function setStateDialog) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      setStateDialog(() {}); // Refresh dialog setelah gambar dipilih
    } else {
      print('Tidak Ada Foto Yang Dipilih');
    }
  }

  void simpanFoto() async {
    if (tSoal.text.isEmpty || selectedTag.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Teks dan tag harus diisi!')),
      );
      return;
    }

    try {
      String? localImagePath;

      if (_image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final fileNama = path.basename(_image!.path);
        final localImage = await _image!.copy('${directory.path}/$fileNama');
        localImagePath = localImage.path;
      }

      final soalText = tSoal.text;
      final savedData = {
        'imagePath': localImagePath,
        'text': soalText,
        'tag': selectedTag,
        'answers': [],
        'tanggal': DateTime.now().toString(), // Simpan waktu saat soal dibuat
      };

      setState(() {
        box.add(savedData);
        _image = null;
        tSoal.clear();
        selectedTag = '';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Teks berhasil disimpan!')),
      );

      Navigator.pop(context);
    } catch (e) {
      print('Gagal menyimpan teks: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan teks!')),
      );
    }
  }

  void resetInput() {
    tSoal.clear();
    _image = null;
    selectedTag = '';
  }

  void tanyaSoal() {
    resetInput();
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Upload Pertanyaan"),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                  resetInput();
                },
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tSoal,
                  decoration: const InputDecoration(hintText: 'Tulis Soal !'),
                ),
                _image == null
                    ? const Text("No Image Was Picked")
                    : Image.file(_image!), // Tampilkan gambar yang di-upload
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    pilihFoto(setStateDialog); // Refresh dialog setelah memilih gambar
                  },
                  child: const Text("Pick Foto"),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedTag.isEmpty ? null : selectedTag,
                  hint: const Text('Pilih Filter'),
                  onChanged: (newValue) {
                    setState(() {
                      selectedTag = newValue!;
                    });
                    setStateDialog(() {}); // Perbarui dialog setelah memilih tag
                  },
                  items: ['Pelajaran', 'Non-pelajaran', 'Peminatan']
                      .map((tag) => DropdownMenuItem<String>(
                            value: tag,
                            child: Text(tag),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: simpanFoto,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }

  void applyFilter(String tag) {
    setState(() {
      filterTag = tag == 'Semua' ? '' : tag;
      activeFilter = tag;
    });
  }

  void navigateToDetailPage(int index) async {
    final questionData = box.getAt(index) as Map;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailPage(index: index, questionData: questionData),
      ),
    );
    setState(() {});
  }

  ElevatedButton buildFilterButton(String tag) {
    bool isActive = activeFilter == tag;
    return ElevatedButton(
      onPressed: () {
        applyFilter(tag);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        backgroundColor: isActive ? Colors.grey : Colors.blue,
      ),
      child: Text(tag, style: const TextStyle(color: Colors.white)),
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
        title: const Text("Diskusi PR"),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.history, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/history');
                  },
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/pertanyaan');
                  },
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('images/tole.png'),
                        radius: 24,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            tanyaSoal();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 50),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Soal apa yang ingin kamu tanyain?',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: IconButton(
                          icon: const Icon(Icons.photo_camera, color: Colors.grey),
                          onPressed: () {
                            tanyaSoal();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            tanyaSoal();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),
                          child: const Text('Upload'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Filter berdasarkan:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        buildFilterButton('Semua'),
                        const SizedBox(width: 10),
                        buildFilterButton('Pelajaran'),
                        const SizedBox(width: 10),
                        buildFilterButton('Non-pelajaran'),
                        const SizedBox(width: 10),
                        buildFilterButton('Peminatan'),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, Box box, _) {
                      final List<dynamic> filteredData = box.values
                          .where((data) =>
                              filterTag.isEmpty || data['tag'] == filterTag)
                          .toList();

                      if (filteredData.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Center(
                            child: Text(
                              'Belum ada soal yang diajukan',
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final soal = filteredData[index];
                          final imagePath = soal['imagePath'] as String?;
                          final soalText = soal['text'] as String;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                navigateToDetailPage(index);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        soalText,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      if (imagePath != null)
                                        Image.file(File(imagePath)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
