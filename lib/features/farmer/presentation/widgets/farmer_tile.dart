import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vet_mkononi/core/constants/app_colors.dart';
import 'package:vet_mkononi/core/widgets/app_text_styles.dart';
import 'package:vet_mkononi/features/farmer/domain/entities/farmer.dart';

import 'custom_bottom_sheet_widget.dart';

typedef OnEditCallback = void Function();
typedef OnDeleteCallback = void Function();

class FarmerTile extends StatelessWidget {
  final Farmer farmer;
  final OnEditCallback onEdit;
  final OnDeleteCallback onDelete;

  const FarmerTile({super.key, required this.farmer, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 80.0,
                    width:  80.0,
                    decoration: BoxDecoration(
                        color:  Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(farmer.msisdn, style: AppTextStyles.body,),
                          SizedBox(height: 3.0,),
                          Text(farmer.firstName, style: AppTextStyles.subheadingA1,),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_pin, size: 14.0, color: AppColors.subHeading,),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text(farmer.location, style: AppTextStyles.body,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => CustomBottomSheetWidget(
                      farmer: farmer,
                      onEdit: (){
                        onEdit();
                      },
                      onDelete: () {
                        onDelete();
                      },
                    ),
                  );
                },
                icon: Icon(Icons.more_vert_rounded, color: AppColors.secondary,))
          ],
        ),
      ),
    );
  }
}
