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
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                // databaseController.pickImage();
                showAlertBox(databaseController);
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
              height: 25,
            ),
            Center(
              child: Container(
                height: 80,
                color: Colors.amber,
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
              height: 25,
            ),
            Center(
              child: TextFormField(
                controller: databaseController.emailCntrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please fill";
                  } else {
                    return null;
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
            const SizedBox(
              height: 25,
            ),
            Center(
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
            GestureDetector(
              onTap: () {
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
    );
  }
}

showAlertBox(DatabaseController databaseController){

  Get.defaultDialog(
    title: "Add image",
    content:const Text("Add image from"),
    actions: [
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
    ]
  );
}