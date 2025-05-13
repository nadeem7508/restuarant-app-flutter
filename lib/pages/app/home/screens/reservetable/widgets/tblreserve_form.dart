import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';

import 'package:zainab_restuarant_app/pages/registration/success_screen/table_reserve_success.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';
import 'package:zainab_restuarant_app/utils/validators/validation.dart';

class tblreserve_form extends StatefulWidget {
  const tblreserve_form({
    super.key,
  });

  @override
  State<tblreserve_form> createState() => _tblreserve_formState();
}

class _tblreserve_formState extends State<tblreserve_form> {
  final personController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
   GlobalKey<FormState> tablereserveformkey = GlobalKey<FormState>();
//select date 
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }
//select time
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        timeController.text = pickedTime.format(context);
      });
    }
  }

   // **Save reservation in Firestore**
  Future<void> _saveReservation() async {
    if (!tablereserveformkey.currentState!.validate()) return;

    String persons = personController.text;
    String date = dateController.text;
    String time = timeController.text;

    try {
      // **Check if the time is already booked**
      var existingReservation = await FirebaseFirestore.instance
          .collection('table_reservations')
          .where('date', isEqualTo: date)
          .where('time', isEqualTo: time)
          .get();

      if (existingReservation.docs.isNotEmpty) {
        // **Show error if the table is already booked**
        TLoaders.errorSnackBar(
            title: "Time Slot Unavailable",
            message: "This time slot is already booked. Please choose another.");
        return;
      }

      // **Save data to Firestore**
      await FirebaseFirestore.instance.collection('table_reservations').add({
        'persons': persons,
        'date': date,
        'time': time,
        'timestamp': FieldValue.serverTimestamp(), // Store server time
      });

      // **Show success message**
      TLoaders.successSnackBar(
          title: 'Congratulations!', message: 'Table Reserved Successfully');

      // **Navigate to success screen**
      Get.to(() => TableReserveSuccess());
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: "Something went wrong.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: tablereserveformkey,
      child: Column(
        children: [
          Container(
             decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      //persons
            child: TextFormField(
              controller: personController,
              validator: (value) => TValidator.validateEmptyText("Person", value),
              decoration: InputDecoration(
                 prefixIcon: Icon(
                  Icons.person,
                  color:  Color.fromARGB(255, 11, 77, 127),
                ),
                labelText: TTexts.people,
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
          //date
          Container(
             decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
            child: TextFormField(
              controller: dateController,
               readOnly: true,
                validator: (value) => TValidator.validateEmptyText("Date", value),
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.date_range,
                  color:  Color.fromARGB(255, 11, 77, 127),
                ),
                
                labelText: TTexts.date,
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
          //time
          Container(
             decoration: BoxDecoration(
       color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
            child: TextFormField(
              controller: timeController,
              readOnly: true,
               validator: (value) => TValidator.validateEmptyText("Time", value),
              onTap: () => _selectTime(context),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.timer,
                  color:  Color.fromARGB(255, 11, 77, 127),
                ),
                
                labelText: TTexts.time,
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
            onpressed: _saveReservation,
            title: TTexts.reserve,
          ),
        ],
      ),
    );
  }
}
