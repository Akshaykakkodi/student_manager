import 'package:hive_flutter/hive_flutter.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String dateOfBirth;

  @HiveField(2)
  late String email;


 @HiveField(3)
   String? address;

   @HiveField(4)
   String? imagePath;
  
  Student({required this.name, required this.dateOfBirth, required this.email, this.address,this.imagePath});

 
}
