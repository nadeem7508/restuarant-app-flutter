
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';

class JobModel {
  final String image;
  final String name;
  

  JobModel({
    
    required this.name, required this.image,
  });


}
final List<JobModel> jobs= [
JobModel(image: TImages.jobs, name: 'Manager', ),
  JobModel(image: TImages.jobs, name: 'Cleaner', ),
  
 
];