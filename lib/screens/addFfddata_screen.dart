import 'dart:convert';

//import 'dart:js'; //for flutter web
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:datatable3/isar/ffd.dart';
//import 'home_screen.dart';

class AddFfdRecords extends StatefulWidget {
  final Isar isar;

  const AddFfdRecords({Key? key, required this.isar}) : super(key: key);
  @override
  _AddFfdRecordsState createState() => _AddFfdRecordsState();
}

class _AddFfdRecordsState extends State<AddFfdRecords> {
  List<Ffd>? ffdDataListIsar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.grey[200],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      color: Colors.teal,
                      onPressed: () {
                        ReadJsonData(widget.isar);
                        // _submit(newFfd);
                      },
                      child: Text('Load Json',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                      color: Colors.teal,
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           HomeScreen(isar: widget.isar)),
                        // );
                      },
                      child:
                          Text('Back ', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                        onPressed: () {
                          // _isarDataList();
                        },
                        child: Text("readDB")),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                        onPressed: () {
                          // clearAll();
                        },
                        child: Text("Delete Data "))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// _isarDataList() async {
//   int count = 1;
//   await readFfd();
//  // readFfd();
//   for (int i = 0; i < ffdDataListIsar!.length; i++) {
//     count = i;
//     print(
//         "${i},${ffdDataListIsar![i].brandName.toString()},${ffdDataListIsar![i].approved.toString()}");
//   }
//   print("$count number of reocrd found in isar");
// }

// clearAll() async {
//   final ffdCollection = widget.isar.ffds;
//   final getFfdData = await ffdCollection.where().findAll();
//   await widget.isar.writeTxn((isar) async {
//     for (var ffdData in getFfdData) {
//       ffdCollection.delete(ffdData.ffdId);
//     }
//   });
//
//   setState(() {});
// }
}

Future<void> ReadJsonData(Isar isar) async {
  String data = await rootBundle.loadString('assets/sample.json');
  final jsonResult = json.decode(data);
  List<FFDTABLE> jsonModelList = [];
  // synchronously read file contents
  final Map<String, dynamic> jsonMap = jsonResult;
  var jsonResultMap = jsonMap["ffddata"];

  if (jsonResultMap != null) {
    print("json data loading started");
    jsonResultMap.forEach((item) {
      jsonModelList.add(FFDTABLE(
          modifierId: item["modifierId"],
          brandName: item["brandName"],
          modifierLastName: item["modifierLastName"],
          version: item["version"],
          metformin: item["metformin"],
          modifierMiddleName: item["modifierMiddleName"],
          sulfonylurea: item["sulfonylurea"],
          inhibitorsDpp: item["inhibitorsDpp"],
          type: item["type"],
          category: item["category"],
          id: item["id"],
          oldMedicinesIds: item["oldMedicinesIds"],
          thiazolidinediones: item["thiazolidined iones"],
          meglitinide: item["meglitinide"],
          inhibitorsAgi: item["inhibitorsAgi"],
          genericName: item["genericName"],
          status: item["status"],
          modifierFirstName: item["modifierFirstName"],
          isDiabetesMedicine: item["isDiabetesMedicine"],
          oldMedicinesNos: item["oldMedicinesNos"],
          modifierSalutation: item["modifierSalutation"],
          approved: item["approved"]));
    });
    print("json data loading ended ");
  }
  final isarModels = jsonModelList.map(Ffd.fromModel).toList();
  print("Data insertion started ");
  print(DateTime.now().millisecondsSinceEpoch);

  await isar.writeTxn(() async {
    await isar.ffds.putAll(isarModels); // insert & update
  });
  print(DateTime.now().millisecondsSinceEpoch);
  print("Data insertion ended ");
}

class FFDTABLE {
  String? modifierId;
  String? brandName;
  String? modifierLastName;
  int? version;
  String? metformin;
  String? modifierMiddleName;
  String? sulfonylurea;
  String? inhibitorsDpp;
  String? type;
  String? category;
  String? id;
  List? oldMedicinesIds;
  String? thiazolidinediones;
  String? meglitinide;
  String? inhibitorsAgi;
  String? genericName;
  bool? status;
  String? modifierFirstName;
  bool? isDiabetesMedicine;
  List? oldMedicinesNos;
  String? modifierSalutation;
  bool? approved;

  //{ } - implies named arguments
  FFDTABLE(
      {this.modifierId,
      this.brandName,
      this.modifierLastName,
      this.version,
      this.metformin,
      this.modifierMiddleName,
      this.sulfonylurea,
      this.inhibitorsDpp,
      this.type,
      this.category, //
      this.id, //
      this.oldMedicinesIds, //
      this.thiazolidinediones, //
      this.meglitinide, //
      this.inhibitorsAgi,
      this.genericName,
      this.status,
      this.modifierFirstName,
      this.isDiabetesMedicine,
      this.oldMedicinesNos, //
      this.modifierSalutation,
      this.approved});

  @override
  String toString() {
    return "{modifierId:$modifierId,brandName:$brandName,modifierLastName:$modifierLastName,version:$version,metformin:$metformin,modifierMiddleName:$modifierMiddleName,sulfonylurea:$sulfonylurea,inhibitorsDpp:$inhibitorsDpp,type:$type,category:$category,id:$id,oldMedicinesIds:$oldMedicinesIds,thiazolidinediones:$thiazolidinediones,meglitinide:$meglitinide,inhibitorsAgi:$inhibitorsAgi,genericName:$genericName,status:$status,modifierFirstName:$modifierFirstName,isDiabetesMedicine:$isDiabetesMedicine,modifierSalutation:$modifierSalutation,oldMedicinesNos:$oldMedicinesNos,approved:$approved}";

    //return "{modifierId:$modifierId,brandName:$brandName,modifierLastName:$modifierLastName,version:$version,metformin:$metformin,modifierMiddleName:$modifierMiddleName,sulfonylurea:$sulfonylurea,inhibitorsDpp:$inhibitorsDpp,type:$type,category:$category,id:$id,oldMedicinesIds:$oldMedicinesIds,thiazolidinediones:$thiazolidinediones,meglitinide:$meglitinide,inhibitorsAgi:$inhibitorsAgi,genericName:$genericName,status:$status,modifierFirstName:$modifierFirstName,isDiabetesMedicine:$isDiabetesMedicine,modifierSalutation:$modifierSalutation,oldMedicinesNos:$oldMedicinesNos,approved:$approved}";
  }
}
