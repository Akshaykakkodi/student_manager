import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentdatabase/controller/database_controller.dart';
import 'package:studentdatabase/view/student_add_screen.dart';
import 'package:studentdatabase/view/student_page.dart';

class StudentDisplayScreen extends StatelessWidget {
  const StudentDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.find();
    databaseController.loadData();
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => databaseController.isSearching.value == false
            ? const Text(
                "Students",
                style: TextStyle(color: Colors.white),
              )
            : TextFormField(
                controller: databaseController.searchCntrl,
                onChanged: (value) {
                  databaseController.search(value);
                  log(databaseController.searchResult.toString());
                },
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          databaseController.searchCntrl.clear();
                          databaseController.searchResult.clear();
                          databaseController.toggleSearch();
                        },
                        child: const Icon(Icons.close)),
                    constraints:
                        const BoxConstraints(maxHeight: 50, maxWidth: 250),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              )),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  databaseController.toggleSearch();
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          )
        ],
        backgroundColor: Colors.teal[200],
      ),
      body: Obx(
        () => SizedBox(
          height: double.infinity,
          width: double.infinity,
          child:databaseController.searchResult.isEmpty? ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: databaseController.studentList.length,
            itemBuilder: (context, index) {
              var data = databaseController.studentList;
              return GestureDetector(
                onTap: () {
                  Get.to(StudentPage(index: index,));
                },
                child: ListTile(
                  title: Text(data[index].name),
                  subtitle: Text(data[index].email),
                  trailing: GestureDetector(
                    onTap: () {
                      // databaseController.deleteStudent(index);
                      showAlertBox(databaseController,index);
                    },
                    child: const Icon(Icons.delete,color: Colors.red,)),
                ),
              );
            },
          ):

          ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: databaseController.searchResult.length,
            itemBuilder: (context, index) {
              var data = databaseController.searchResult;
              return ListTile(
                title: Text(data[index].name),
                subtitle: Text(data[index].email),
                trailing:const Icon(Icons.delete,color: Colors.red,),

              );
            },
          )

        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            
           Get.to(const StudentAddScreen());
           
           
          },
          child: const Icon(Icons.add)),
    );
  }
}


showAlertBox(DatabaseController databaseController,int index){

  Get.defaultDialog(
    title: "Alert",
    content:const Text("Are you sure?"),
    actions: [
      ElevatedButton(
        onPressed: () {
          databaseController.deleteStudent(index);
          
          Get.back();
          Get.snackbar("Alert", "Deleted successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,

          );
        },
         child:const Text("Delete")),

         ElevatedButton(
        onPressed: () {
          
          Get.back();
        },
         child:const Text("cancel")),
    ]
  );
}