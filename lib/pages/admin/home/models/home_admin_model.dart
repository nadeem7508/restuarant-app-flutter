
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';

class PopularItem {
  final String image;
  final String name;
  

  PopularItem({
    
    required this.name, required this.image,
  });


}
final List<PopularItem> popular= [
PopularItem(image: TImages.productImage1, name: 'Pizza',),
  PopularItem(image: TImages.productImage1, name: 'Kharahi', ),
  PopularItem(image: TImages.productImage1,name: 'Fish', ),
];