import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            AppBar(
              backgroundColor: Colors.greenAccent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/dashboard');
                },
              ),
              elevation: 0,
            ),
            Center(
              child: Image.asset(
                'images/logos.png',
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Buat Akun Mejakita",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Daftar Menggunakan Email Anda",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 120),
                    child: Image.asset(
                      'images/kitten.png',
                      fit: BoxFit.contain,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: "Nama",
                  prefixIcon: const Icon(Icons.person, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.key, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: "Ulangi Password",
                  prefixIcon: const Icon(Icons.key, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Text(
                  "reCAPTCHA Widget Placeholder",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  "MASUK",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
             children: [
              const Padding(padding: EdgeInsets.only(left: 16),
              child: Text("Sudah Punya Akun?"),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: TextButton(
                  onPressed: () {
                   Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
            ),
            const SizedBox(height: 400,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    //Navigator.of(context).pushReplacementNamed('/perbaikan');
  },
  backgroundColor: Colors.transparent,
  elevation: 0, 
  child: ClipRRect(
    borderRadius: BorderRadius.circular(16.0), 
    child: Image.asset(
      'images/wapics.png', 
      fit: BoxFit.cover,
      width: 56.0,
      height: 56.0,
    ),
  ),
),
floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}