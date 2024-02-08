import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:input_nilai/view/add_data.dart';
import 'package:input_nilai/view/edit_data.dart';
import 'package:input_nilai/view/login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                    (route) => false);
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('DATA').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs
                    .map((e) => ItemCard(
                          nama: e['nama'],
                          nim: e['nim'],
                          prodi: e['prodi'],
                          semester: e['semester'],
                          kelas: e['kelas'],
                          alamat: e['alamat'],
                          nilai_tugas: e['nilai_tugas'],
                          nilai_praktik: e['nilai_praktik'],
                          nilai_kehadiran: e['nilai_kehadiran'],
                          nilai_uas: e['nilai_uas'],
                          nilai_ratarata: e['nilai_ratarata'],
                          iconEdit: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditData(
                                          nama: e['nama'],
                                          nim: e['nim'],
                                          prodi: e['prodi'],
                                          semester: e['semester'],
                                          kelas: e['kelas'],
                                          alamat: e['alamat'],
                                          nilaitugas: e['nilai_tugas'],
                                          nilaipraktik: e['nilai_praktik'],
                                          nilaikehadiran: e['nilai_kehadiran'],
                                          nilaiuas: e['nilai_uas'],
                                          nilairatarata: e['nilai_ratarata']),
                                    ));
                              },
                              icon: Icon(Icons.edit)),
                          iconDelete: IconButton(
                              onPressed: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'Hapus Data?',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    FirebaseFirestore.instance
                                        .collection('DATA')
                                        .doc(e['nama'])
                                        .delete();
                                  },
                                ).show();
                              },
                              icon: Icon(Icons.delete)),
                        ))
                    .toList(),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddData(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
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
  final Widget iconDelete, iconEdit;

  const ItemCard(
      {super.key,
      required this.nama,
      required this.nim,
      required this.prodi,
      required this.semester,
      required this.kelas,
      required this.alamat,
      required this.nilai_tugas,
      required this.nilai_praktik,
      required this.nilai_kehadiran,
      required this.nilai_uas,
      required this.nilai_ratarata,
      required this.iconDelete,
      required this.iconEdit});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue.shade200),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(flex: 1, child: Text('Nama')),
                  Expanded(flex: 1, child: Text(nama))
                ],
              ),
              Row(
                children: [
                  Expanded(flex: 1, child: Text('NIM')),
                  Expanded(flex: 1, child: Text(nim))
                ],
              ),
              Row(
                children: [
                  Expanded(flex: 1, child: Text('Prodi')),
                  Expanded(flex: 1, child: Text(prodi))
                ],
              ),
              Row(
                children: [
                  Expanded(flex: 1, child: Text('Semester')),
                  Expanded(flex: 1, child: Text(semester))
                ],
              ),
              Row(
                children: [
                  Expanded(flex: 1, child: Text('Kelas')),
                  Expanded(flex: 1, child: Text(kelas))
                ],
              ),
              Row(
                children: [
                  Expanded(flex: 1, child: Text('Alamat')),
                  Expanded(flex: 1, child: Text(alamat))
                ],
              ),
              Row(
                children: [
                  Expanded(flex: 1, child: Text('Nilai Tugas')),
                  Expanded(flex: 1, child: Text(nilai_tugas))
                ],
              ),
              Row(
                children: [
                  Expanded(flex: 1, child: Text('Nilai Praktik')),
                  Expanded(flex: 1, child: Text(nilai_praktik))
                ],
              ),
              Row(
                children: [
                  Expanded(flex: 1, child: Text('Nilai Kehadiran')),
                  Expanded(flex: 1, child: Text(nilai_kehadiran))
                ],
              ),
              Row(
                children: [
                  Expanded(flex: 1, child: Text('Nilai UAS')),
                  Expanded(flex: 1, child: Text(nilai_uas))
                ],
              ),
              Row(
                children: [
                  Expanded(flex: 1, child: Text('Nilai Rata')),
                  Expanded(flex: 1, child: Text(nilai_ratarata))
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconEdit,
              iconDelete
              // IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              // IconButton(
              //     onPressed: () {
              //       FirebaseFirestore.instance
              //           .collection('DATA')
              //           .doc(e['nama_kost'])
              //           .delete();
              //     },
              //     icon: Icon(Icons.delete)),
            ],
          ),
        )
      ],
    );
  }
}
