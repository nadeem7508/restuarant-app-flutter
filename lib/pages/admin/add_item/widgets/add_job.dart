import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/admin/admin_bottomnav.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';

class AddJob extends StatefulWidget {
  const AddJob({super.key});

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  final TextEditingController jobNameController = TextEditingController();
  final TextEditingController jobDescriptionController = TextEditingController();
  String selectedJob = "Manager";
  List<String> job = ["Manager", "Security Gaurd"];

   Future<void> _addJobToFirestore() async {
    if (jobNameController.text.isEmpty || jobDescriptionController.text.isEmpty) {
      TLoaders.errorSnackBar(title: 'Error', message: 'All fields are required!');
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('jobs').add({
        'jobName': jobNameController.text,
        'vacancy': selectedJob,
        'description': jobDescriptionController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      TLoaders.successSnackBar(title: 'Success', message: 'Job added successfully!');
      Get.to(() => AdminBottomnav());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to add job.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add New Job',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                  onPressed: () {
                  jobNameController.clear();
                  jobDescriptionController.clear();
                },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                        color: Color.fromARGB(255, 11, 77, 127), fontSize: 14),
                  ))
            ],
          ),
          SizedBox(height: TSizes.spaceBtwSections),
          //data upload jobs related

          // Job NAME
          Text(
            'Job Name',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              controller: jobNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // Circular border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Colors.grey.shade100), // Default border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 11, 77, 127), width: 2),
                ),
              ),
            ),
          ),

          SizedBox(height: TSizes.spaceBtwItems),
          //category of job
          Text(
            'Vacany For',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonHideUnderline(
              // Removes the bottom line
              child: DropdownButton<String>(
                value: selectedJob,
                dropdownColor: Colors.blue,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 11, 77, 127),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedJob = newValue!;
                  });
                },
                items: job.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems),

          //description of job
          Text(
            'Description',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),

          SizedBox(height: TSizes.spaceBtwItems),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              controller: jobDescriptionController,
              maxLines: null, // Allows the field to expand as needed
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // Circular border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Colors.grey.shade100), // Default border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 11, 77, 127), width: 2),
                ),
              ),
            ),
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          //savebutton

          Container(
              width: double.infinity,
              child: onboardingbtn(
                  onpressed: _addJobToFirestore,
                  title: 'Save')),
        ],
      ),
    );
  }
}
