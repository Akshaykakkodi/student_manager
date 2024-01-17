import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentdatabase/controller/database_controller.dart';
import 'package:studentdatabase/model/student.dart';

class StudentAddScreen extends StatelessWidget {
  const StudentAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        title: const Text(
          "Add Student",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: databaseController.fkey.value,
        child: Container(
          padding:const EdgeInsets.only(left: 30,right: 30) ,
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  
                  _showBottomSheet(databaseController);
                },
                child: Obx(
                  () => Container(
                    height: 180,
                    width: 150,
                    color: Colors.blueGrey[200],
                    child: databaseController.image.value != null
                        ? Image.file(
                            databaseController.image.value!,
                            fit: BoxFit.fill,
                          )
                        : const Icon(Icons.add_a_photo),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: SizedBox(
                  height: 80,
                  
                  child: TextFormField(
                    controller: databaseController.nameCntrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please fill";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Name",
                        // constraints:
                            // const BoxConstraints(maxHeight: 50, maxWidth: 300),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60))),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: SizedBox(
                  height: 80,
                  child: TextFormField(
                    controller: databaseController.emailCntrl,
                    validator: (value) {
                      if(databaseController.emailRegex.hasMatch(value!)){
                        if (value.isEmpty) {
                        return "Please fill";
                      } else {
                        return null;
                      }
                      }else{
                        return "enter valid email";
                      }
                      
                    },
                    decoration: InputDecoration(
                        hintText: "Email",
                        constraints:
                            const BoxConstraints(maxHeight: 50, maxWidth: 300),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60))),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: SizedBox(
                  height: 80,
                  child: TextFormField(
                    controller: databaseController.addressCntrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please fill";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Address",
                        constraints:
                            const BoxConstraints(maxHeight: 50, maxWidth: 300),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60))),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 45,
                width: 200,
                decoration: BoxDecoration(border: Border.all()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(() => Text(databaseController.dob.value)),
                    GestureDetector(
                        onTap: () {
                          databaseController.pickDob(context);
                        },
                        child: const Icon(Icons.calendar_month))
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(
                  height: 30,
                ),
              ),
              CupertinoButton(
                minSize: 0,
                padding: EdgeInsets.zero,
                onPressed: () {
                  if(databaseController.validateImage()){
                   if(databaseController.fkey.value.currentState!.validate()){
                    databaseController.addStudent(Student(
                      name: databaseController.nameCntrl.text,
                      dateOfBirth: databaseController.dob.value,
                      email: databaseController.emailCntrl.text,
                      address: databaseController.addressCntrl.text,
                      imagePath: databaseController.imgPath.value
                      
                      ));
                      Get.back();
                  }
                   
                  }
                  else{
                    Get.snackbar(
                      
                      "", "Please add a image!!",
                      backgroundColor: Colors.red[200]
                      );
                  }
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.teal[200]),
                  child: const Center(
                      child: Text("Add",
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}


_showBottomSheet(DatabaseController databaseController){
  Get.bottomSheet(
    Container(
      height: 250,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         const Text("Add image from"),
          ElevatedButton(
        onPressed: () {
          databaseController.pickImage(ImageSource.camera);
          Get.back();
        },
         child:const Text("Camera")),

         ElevatedButton(
        onPressed: () {
          databaseController.pickImage(ImageSource.gallery);
          Get.back();
        },
         child:const Text("Gallery")),
        ],
      ),
    )
  );
}

