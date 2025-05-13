import 'package:flutter/material.dart';

import 'package:zainab_restuarant_app/pages/admin/add_item/widgets/add_item.dart';
import 'package:zainab_restuarant_app/pages/admin/add_item/widgets/add_job.dart';
import 'package:zainab_restuarant_app/pages/admin/add_item/widgets/add_menu.dart';
import 'package:zainab_restuarant_app/pages/admin/add_item/widgets/admin_submenu_upload%20.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';


class AddItemsAdmin extends StatelessWidget {
  const AddItemsAdmin({super.key});

   // Track selected items
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        
        appBar: AppBar(
        automaticallyImplyLeading: false,
          title: Text(
            'Add Items',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: Colors.amber.shade300,
          bottom: TabBar(
            labelColor:  Color.fromARGB(255, 11, 77, 127),
            tabs: [
              Tab(text: ' Menu',),
              Tab(text: ' Sub Menu',),
              Tab(text: " Product"),
              Tab(text: " Jobs"),
            ],
          ),
        ),
        body:
            //products and jobs added
    
            SafeArea(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: TabBarView(
              children: [
                AddMenu(),
                AdminSubmenuUpload(),
                add_item(),
                AddJob(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

