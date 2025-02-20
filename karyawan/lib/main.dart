import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      tittle: 'Daftar Karyawan',
      theme: ThemeDta(
        colorScheme: ColorScheme.fromSeed(seedColor:Colors.deepPurple),
        useMaterial3:true
      ),
      home: cons MyHomePage(),
    );
  } 
}

Class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});

  Future<List<Karyawan>> _readJsonData() async {
    final String response = await rootBundle.loadString('assets/karyawan.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json)) => Karyawan.fromJson(json)).toList();
  }

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      tittle: cons Text('Daftar Karyawan'),
    ),
    body: FutureBuilder<List<Karyawan>>(
      future:_readJsonData(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index){
              return ListTile(
                tittle: Text(sanpshot.data![index].nama,
                style: cons TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAligment: CrossAxisAligment.start,
                  childersn:[
                    Text('umur: ${snapshot.data![index].umur} tahun'),
                    Text('Alamat: ${snapshot.data![index].alamat.jalan},'
                                  '${snapshot.data![index].alamat.kota},'
                                  '${snapshot.data![index].alamat.provinsi}'),
                    )
                  ]
                )
                );
              )
            },
          );

        } else if (snapshot.hasError){
          return Center(
            child: Text('${snapshot.error}'),
          );
        }
      }
    )
  );
}
}
