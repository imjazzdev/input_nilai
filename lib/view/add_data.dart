import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:input_nilai/view/home.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  var nama = TextEditingController();
  var nim = TextEditingController();
  var semester = TextEditingController();
  var kelas = TextEditingController();
  var alamat = TextEditingController();
  var nilai_tugas = TextEditingController();
  var nilai_praktik = TextEditingController();
  var nilai_kehadiran = TextEditingController();
  var nilai_uas = TextEditingController();
  var nilai_ratarata = TextEditingController();

  List prodi = [
    'Informatika',
    'Sistem Informasi',
    'Manajemen',
    'Komunikasi',
    'Akuntansi',
  ];
  String? valProdi = 'Informatika';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Data'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: nama,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue.shade300,
                labelText: 'Nama'),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: nim,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue.shade300,
                labelText: 'NIM'),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(), color: Colors.blue.shade300),
            child: DropdownButton(
                isExpanded: true,
                value: valProdi,
                items: prodi
                    .map((value) => DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    valProdi = value as String?;
                  });
                }),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: semester,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue.shade300,
                labelText: 'Semester'),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: kelas,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue.shade300,
                labelText: 'Kelas'),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: alamat,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue.shade300,
                labelText: 'Alamat'),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: nilai_tugas,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue.shade300,
                labelText: 'Nilai Tugas'),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: nilai_praktik,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue.shade300,
                labelText: 'Nilai Praktik'),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: nilai_kehadiran,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue.shade300,
                labelText: 'Nilai Kehadiran'),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: nilai_uas,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue.shade300,
                labelText: 'Nilai UAS'),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: nilai_ratarata,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue.shade300,
                labelText: 'Nilai Rata Rata'),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: 'Simpan Data?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    addData();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                        (route) => false);
                  },
                ).show();
              },
              child: Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }

  Future addData() async {
    final doc =
        FirebaseFirestore.instance.collection('DATA').doc('${nama.text}');
    final order = Data(
        nama: nama.text,
        nim: nim.text,
        prodi: valProdi.toString(),
        semester: semester.text,
        kelas: kelas.text,
        alamat: alamat.text,
        nilai_tugas: nilai_tugas.text,
        nilai_praktik: nilai_praktik.text,
        nilai_kehadiran: nilai_kehadiran.text,
        nilai_uas: nilai_uas.text,
        nilai_ratarata: nilai_ratarata.text);
    final json = order.toJson();
    await doc.set(json);
  }
}

class Data {
  final String nama,
      nim,
      prodi,
      semester,
      kelas,
      alamat,
      nilai_tugas,
      nilai_praktik,
      nilai_kehadiran,
      nilai_uas,
      nilai_ratarata;

  Data(
      {required this.nama,
      required this.nim,
      required this.prodi,
      required this.semester,
      required this.kelas,
      required this.alamat,
      required this.nilai_tugas,
      required this.nilai_praktik,
      required this.nilai_kehadiran,
      required this.nilai_uas,
      required this.nilai_ratarata});

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'nim': nim,
        'prodi': prodi,
        'semester': semester,
        'kelas': kelas,
        'alamat': alamat,
        'nilai_tugas': nilai_tugas,
        'nilai_praktik': nilai_praktik,
        'nilai_kehadiran': nilai_kehadiran,
        'nilai_uas': nilai_uas,
        'nilai_ratarata': nilai_ratarata
      };
}
