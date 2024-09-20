import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _rememberDevice = false;

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "Login Ke Mejakita",
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
              "Masuk menggunakan akun mejakita",
              style: TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: TextField(
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.grey),
                hintText: "Email atau Username",
                prefixIcon: const Icon(Icons.email, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _rememberDevice,
                      onChanged: (value) {
                        setState(() {
                          _rememberDevice = value!;
                        });
                      },
                    ),
                    const Text("Ingat Perangkat Ini"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: TextButton(
                  onPressed: () {
                   Navigator.of(context).pushReplacementNamed('/forgot');
                  },
                  child: const Text(
                    "Lupa Password?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40,),
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
          const SizedBox(height: 30,),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 16),
              child: Text("Belum Punya Akun?"),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: TextButton(
                  onPressed: () {
                   Navigator.of(context).pushReplacementNamed('/signup');
                  },
                  child: const Text(
                    "Daftar Sekarang",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}