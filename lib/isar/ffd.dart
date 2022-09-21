import 'package:isar/isar.dart';

import '../screens/addFfddata_screen.dart';
part 'ffd.g.dart';
@Collection()
class Ffd {
  Id ffdId = Isar.autoIncrement; // you can also use id = null to auto increment
  String? modifierId;
  String? brandName;
  String? type;
  String? id;
  String? genericName;
  bool? approved;

  Ffd(
      {this.modifierId,
        this.brandName,
        this.type,
        this.id,
        this.approved,
        this.genericName});

//Convert into map
  Map toJson() => {
    'modifierId': modifierId,
    'brandName': brandName,
    'type': type,
    'id': id,
    'genericName': genericName
  };

  factory Ffd.fromModel(FFDTABLE model) {
    return Ffd(
      modifierId: model.modifierId,
      brandName: model.brandName,
      type: model.type,
      id: model.id,
      genericName: model.genericName,
      approved: model.approved,
    );
  }
}