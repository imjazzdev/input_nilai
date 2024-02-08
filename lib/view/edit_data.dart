import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:input_nilai/view/home.dart';

class EditData extends StatefulWidget {
  final String nama,
      nim,
      prodi,
      semester,
      kelas,
      alamat,
      nilaitugas,
      nilaipraktik,
      nilaikehadiran,
      nilaiuas,
      nilairatarata;

  const EditData(
      {super.key,
      required this.nama,
      required this.nim,
      required this.prodi,
      required this.semester,
      required this.kelas,
      required this.alamat,
      required this.nilaitugas,
      required this.nilaipraktik,
      required this.nilaikehadiran,
      required this.nilaiuas,
      required this.nilairatarata});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  @override
  void initState() {
    nama.text = widget.nama;
    nim.text = widget.nim;
    valProdi = widget.prodi;
    semester.text = widget.semester;
    kelas.text = widget.kelas;
    alamat.text = widget.alamat;
    nilai_tugas.text = widget.nilaitugas;
    nilai_praktik.text = widget.nilaipraktik;
    nilai_kehadiran.text = widget.nilaikehadiran;
    nilai_uas.text = widget.nilaiuas;
    nilai_ratarata.text = widget.nilairatarata;

    super.initState();
  }

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
        title: Text('Edit Data'),
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
                  btnOkOnPress: () async {
                    updateData();
                    await Navigator.pushAndRemoveUntil(
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

  Future updateData() async {
    final doc =
        FirebaseFirestore.instance.collection('DATA').doc('${nama.text}');
    doc.update({
      'nama': nama.text ?? widget.nama,
      'nim': nim.text ?? widget.nim,
      'prodi': valProdi.toString() ?? widget.prodi,
      'semester': semester.text ?? widget.semester,
      'kelas': kelas.text ?? widget.kelas,
      'alamat': alamat.text ?? widget.alamat,
      'nilai_tugas': nilai_tugas.text ?? widget.nilaitugas,
      'nilai_praktik': nilai_praktik.text ?? widget.nilaipraktik,
      'nilai_kehadiran': nilai_kehadiran.text ?? widget.nilaikehadiran,
      'nilai_uas': nilai_uas.text ?? widget.nilaiuas,
      'nilai_ratarata': nilai_ratarata.text ?? widget.nilairatarata
    });
  }
}
