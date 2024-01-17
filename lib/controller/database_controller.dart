import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:studentdatabase/model/student.dart';

class DatabaseController extends GetxController {
  var studentList = <Student>[].obs;
  var searchResult = <Student>[].obs;
  var dob=DateFormat('dd/MM/yyyy').format(DateTime.now()).obs;
  var student=Student(name: "", dateOfBirth: "", email: "",address: "",imagePath: "").obs;
  var imgPath="".obs;
  

  var nameCntrl = TextEditingController();
  var emailCntrl = TextEditingController();
  var dateOfBirthCntrl = TextEditingController();
  var searchCntrl = TextEditingController();
  var addressCntrl=TextEditingController();
  
  var fkey = GlobalKey<FormState>().obs;
  var isSearching = false.obs;
  var isEditing=false.obs;

  void addStudent(Student student) async {
    var box = Hive.box<Student>('students');
    box.add(student);
    loadData();

    dispose();
  }


void delete(){
   var box = Hive.box<Student>('students');
   box.clear();
   update();
}
  pickDob(BuildContext context)async{
    var pickedDate=await showDatePicker(
      context:context , 
      initialDate: DateTime(2000), 
      firstDate: DateTime(1900), 
      lastDate: DateTime.now());
      dob.value= DateFormat("dd/MM/yyyy").format(pickedDate!);
  }

  void toggleSearch() {
    isSearching(!isSearching.value);
  }

  void search(String name) {
    String queryName = name.toLowerCase();
    searchResult.value = studentList
        .where((data) => data.name.toLowerCase().contains(queryName))
        .toList();
  }

  void loadData() {
    var box = Hive.box<Student>('students');
    studentList.assignAll(box.values.toList());
  }

 loadStudent(int index){
     var box = Hive.box<Student>('students');
    student.value=  box.getAt(index)!;
     
  }

  @override
  void dispose() {
    nameCntrl.clear();
    emailCntrl.clear();
    dateOfBirthCntrl.clear();
    super.dispose();
  }

  var image = Rxn<File>();
  var picked=Rxn<XFile?>();

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    picked.value = await _picker.pickImage(source: source);

    if (picked.value != null) {
      image.value = File(picked.value!.path);
      imgPath.value=picked.value!.path;
    }
  }

  void toggleEditing(){
    isEditing(!isEditing.value);
    
  }


   void deleteStudent(int index) async {
    var box = Hive.box<Student>('students');
    
    // Ensure that the index is within the bounds of the box
    if (index >= 0 && index < box.length) {

      // Delete the student
      await box.deleteAt(index);

      // Reload the data after deletion
      loadData();
    }
  }



   void editStudent(int index, {String? newName, String? newEmail, String? newAddress}) async {
    var box = Hive.box<Student>('students');

    // Ensure that the index is within the bounds of the box
    if (index >= 0 && index < box.length) {
      // Retrieve the student to be edited
      Student studentToEdit = box.getAt(index)!;

      // Modify the data based on the provided parameters
      if (newName != null) {
        studentToEdit.name = newName;
      }
      
      if (newEmail != null) {
        studentToEdit.email = newEmail;
      }
      if (newAddress != null) {
        studentToEdit.address = newAddress;
      }
      

      // Save the changes back to Hive
      box.putAt(index, studentToEdit);

      // Reload the data after editing
      loadData();
      toggleEditing();
    }
  }


  
}
