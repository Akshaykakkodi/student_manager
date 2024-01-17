import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentdatabase/controller/database_controller.dart';

class StudentPage extends StatelessWidget {
  final int index;
  const StudentPage({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.find();
    databaseController.loadStudent(index);
    var name =
        TextEditingController(text: databaseController.student.value.name);
    var email =
        TextEditingController(text: databaseController.student.value.email);
    var address =
        TextEditingController(text: databaseController.student.value.address);

    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.teal[200],
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                  onTap: () {
                    databaseController.toggleEditing();
                  },
                  child: const Icon(Icons.edit)),
            )
          ],
        ),
        body: databaseController.isEditing.value == false
            ? Container(
                height: double.infinity,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(
                          File(databaseController.student.value.imagePath!)),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Name:"),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(databaseController.student.value.name)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Email:"),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(databaseController.student.value.email)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Date of Birth:"),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(databaseController.student.value.dateOfBirth)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Address:"),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(databaseController.student.value.address!)
                      ],
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.file(
                            File(databaseController.student.value.imagePath!),
                            fit: BoxFit.fill,
                          )),
                      IconButton(
                          onPressed: () {
                            _showBottomSheet(databaseController,);
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: TextFormField(
                      controller: name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please fill";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Name",
                          constraints: const BoxConstraints(
                              maxHeight: 50, maxWidth: 300),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60))),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please fill";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Email",
                          constraints: const BoxConstraints(
                              maxHeight: 50, maxWidth: 300),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60))),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: TextFormField(
                      controller: address,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please fill";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Address",
                          constraints: const BoxConstraints(
                              maxHeight: 50, maxWidth: 300),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60))),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Expanded(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      databaseController.editStudent(index,
                          newName: name.text,
                          newAddress: address.text,
                          newEmail: email.text,
                          newImgPath: databaseController.imgPath.value);
                      Get.back();
                    },
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.teal[200]),
                      child: const Center(
                          child: Text("Update",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20))),
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

_showBottomSheet(DatabaseController databaseController) {
  Get.bottomSheet(Container(
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
              // databaseController.student.value.imagePath=databaseController.image.value!.path;
              Get.back();
            },
            child: const Text("Camera")),
        ElevatedButton(
            onPressed: () {
              databaseController.pickImage(ImageSource.gallery);
              // databaseController.student.value.imagePath=databaseController.imgPath.value;
              Get.back();
            },
            child: const Text("Gallery")),
      ],
    ),
  ));
}
