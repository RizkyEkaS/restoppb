import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final biodata = <String, String>{};

  MainApp({super.key}) {
    biodata['name'] = 'Krusty Krab';
    biodata['email'] = 'krabbypatty@krustykrab.com';
    biodata['phone'] = '+6212345678910';
    biodata['image'] = 'pxfuel.jpg';
    biodata['menu'] = '''
    Krabby Patty Spesial
    Krabby Patty Jumbo
    Krabby Patty Medium
    Krabby Patty Mini''';
    biodata['addr'] = 'Jalan Bikini Bottom';
    biodata['desc'] =
        '''Krusty Krab adalah restoran cepat saji terkemuka di kota bawah air Bikini Bottom. Dimiliki dan dioperasikan oleh Eugene H. Krabs (Tuan Krabs), yang menemukan sandwich Krabby Patty yang terkenal. Tuan Krabs memiliki dua karyawan: Squidward Tentacles dan SpongeBob SquarePants, yang masing-masing bekerja sebagai kasir dan juru masak. Patrick Star juga pernah bekerja di Krusty Krab untuk beberapa tugas singkat di berbagai posisi.''';
    biodata['jam_buka'] = '''
    Senin-Jumat: 09.00 - 20.00
    Sabtu: 10.00 - 22.00
    Minggu: 10.00 - 18.00''';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Restaurant",
      home: Scaffold(
        appBar: AppBar(title: const Text("Restaurant")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              teksKotak(Colors.black, biodata['name'] ?? ''),
              Image(image: AssetImage('assets/${biodata['image'] ?? ''}')),
              SizedBox(height: 10),
              Row(
                children: [
                  btnContact(Icons.alternate_email, Colors.green[900],
                      "mailto:${biodata['email']}"),
                  btnContact(Icons.mark_email_unread_rounded,
                      Colors.blueAccent, "https://wa.me/${biodata['phone']}"),
                  btnContact(Icons.location_on, Colors.deepPurple,
                      "https://maps.app.goo.gl/XUW13AoKf1srnuee8"),
                ],
              ),
              SizedBox(height: 10),
              textAttribute("Menu", biodata['menu'] ?? ''),
              textAttribute("Alamat", biodata['addr'] ?? ''),
              textAttribute("Jam Buka", biodata['jam_buka'] ?? ''),
              SizedBox(height: 10),
              teksKotak(Colors.black38, 'Deskripsi'),
              SizedBox(height: 10),
              Text(
                biodata['desc'] ?? '',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container teksKotak(Color bgColor, String teks) {
  return Container(
    padding: EdgeInsets.all(10),
    alignment: Alignment.center,
    width: double.infinity,
    decoration: BoxDecoration(color: bgColor),
    child: Text(
      teks,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}

Row textAttribute(String judul, String teks) {
  return Row(
    children: [
      Container(
        width: 80,
        child: Text(
          "- $judul:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      Text(teks, style: TextStyle(fontSize: 18)),
    ],
  );
}

Expanded btnContact(IconData icon, var color, String uri) {
  return Expanded(
    child: ElevatedButton(
      child: Icon(icon),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        if (!await launchUrl(Uri.parse(uri))) {
          throw Exception('Tidak dapat memanggil: $uri');
        }
      },
    ),
  );
}
