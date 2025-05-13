import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';
import 'package:zainab_restuarant_app/utils/validators/validation.dart';



class jobapplyform extends StatefulWidget {
  const jobapplyform({
    super.key,
  });

  @override
  State<jobapplyform> createState() => _jobapplyformState();
}

class _jobapplyformState extends State<jobapplyform> {
   final nameController= TextEditingController();
    final emailController = TextEditingController();
    final coverLetterController  = TextEditingController();
    GlobalKey<FormState> jobsformkey = GlobalKey<FormState>();
     File? selectedFile;
  String? fileName;
    String? fileUrl; // To store uploaded file URL
   // **Pick PDF File**
  Future<void> _pickFile() async {
    var status = await Permission.storage.request(); // Request storage permission

    if (status.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Only PDFs allowed
      );

      if (result != null) {
        setState(() {
          selectedFile = File(result.files.single.path!);
          fileName = result.files.single.name;
        });
      }
    } else {
      print("Permission Denied");
    }
  }


  // **Upload CV & Store Data in Firestore**
  Future<void> _submitApplication() async {
    if (!jobsformkey.currentState!.validate() ) {
      TLoaders.errorSnackBar(title: "Error", message: "Please complete all fields");
      return;
    }

    try {
      // **Upload CV if selected**
      if (selectedFile != null) {
        String filePath = "job_applications/${DateTime.now().millisecondsSinceEpoch}_$fileName";
        TaskSnapshot uploadTask = await FirebaseStorage.instance.ref(filePath).putFile(selectedFile!);
        fileUrl = await uploadTask.ref.getDownloadURL();
      }

      // **Store Job Application in Firestore**
      await FirebaseFirestore.instance.collection('jobApplications').add({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
         'coverLetter': coverLetterController.text.trim(),
        'cvUrl': fileUrl ?? "No CV uploaded", // Store "No CV uploaded" if optional
        'jobTitle': "Applied Job", // Adjust based on job selected
        'timestamp': FieldValue.serverTimestamp(),
      });

      // **Success Message**
      TLoaders.successSnackBar(title: "Success", message: "Application submitted successfully!");

      // **Clear Form**
      nameController.clear();
      emailController.clear();
      coverLetterController.clear();
      setState(() {
        selectedFile = null;
        fileName = null;
      });
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: "Something went wrong!");
    }
  }
  @override
  Widget build(BuildContext context) {
   
    return Form(
      key: jobsformkey,
         child: Column(
           children: [
             Container(
                decoration: BoxDecoration(
          color: Colors.white,
           borderRadius: BorderRadius.circular(15),
         ),
               child: TextFormField(
                controller: nameController,
              validator: (value) => TValidator.validateEmptyText('Name',value),
                 decoration: InputDecoration(
                    prefixIcon: Icon(
                     Icons.person,
                     color:  Color.fromARGB(255, 11, 77, 127),
                   ),
                   labelText: TTexts.name,
                   border: OutlineInputBorder(
                     borderRadius:
                         BorderRadius.circular(15), // Circular border
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide: BorderSide(
                         color: Colors
                             .grey.shade100), // Default border color
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide:
                         BorderSide(color:  Color.fromARGB(255, 11, 77, 127), width: 2),
                   ),
                 ),
               ),
             ),
             SizedBox(
               height: TSizes.spaceBtwInputFields,
             ),
             //email
             Container(
                decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(15),
         ),
               child: TextFormField(
                controller: emailController,
              validator: (value) => TValidator.validateEmail(value),
                 decoration: InputDecoration(
                   prefixIcon: Icon(
                     Icons.email,
                     color:  Color.fromARGB(255, 11, 77, 127),
                   ),
                   
                   labelText: TTexts.email,
                   border: OutlineInputBorder(
                     borderRadius:
                         BorderRadius.circular(15), // Circular border
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide: BorderSide(
                         color: Colors
                             .grey.shade100), // Default border color
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide:
                         BorderSide(color:  Color.fromARGB(255, 11, 77, 127), width: 2),
                   ),
                 ),
               ),
             ),
             SizedBox(
               height: TSizes.spaceBtwInputFields,
             ),
             //cv
             Container(
                decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(15),
         ),
               child: TextFormField(
                controller: TextEditingController(text: fileName ?? "Upload CV (Optional - PDF only)"),
             onTap: _pickFile, // Opens file picker when tapped
                 decoration: InputDecoration(
                   prefixIcon: Icon(
                     Icons.upload_file,
                     color:  Color.fromARGB(255, 11, 77, 127),
                   ),
                   
                   labelText: fileName ?? "Upload CV (PDF only)",
                   border: OutlineInputBorder(
                     borderRadius:
                         BorderRadius.circular(15), // Circular border
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide: BorderSide(
                         color: Colors
                             .grey.shade100), // Default border color
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide:
                         BorderSide(color:  Color.fromARGB(255, 11, 77, 127),width: 2),
                   ),
                 ),
               ),
             ),
             SizedBox(height: TSizes.spaceBtwItems,),
             //cover-letter
             Container(
              
                decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(15),
         ),
               child: TextFormField(
                maxLines: null, // Allows the field to expand as needed
  keyboardType: TextInputType.multiline,
                   controller: coverLetterController,
                   
              validator: (value) => TValidator.validateEmptyText('CoverLetter',value),
                 decoration: InputDecoration(
                   contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 16 ),
                   prefixIcon: Icon(Iconsax.text,color:  Color.fromARGB(255, 11, 77, 127),),
                   labelText: TTexts.uploadcover,
                   border: OutlineInputBorder(
                     borderRadius:
                         BorderRadius.circular(15), // Circular border
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide: BorderSide(
                         color: Colors
                             .grey.shade100), // Default border color
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide:
                         BorderSide(color:  Color.fromARGB(255, 11, 77, 127), width: 2),
                   ),
                 ),
               ),
             ),
             //button
             SizedBox(
               height: 100,
             ),
             onboardingbtn(
               onpressed: _submitApplication,
               title: TTexts.submit,
             ),
           ],
         ),
       );
  }
}