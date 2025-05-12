import 'package:flutter/material.dart';
import 'package:vet_mkononi/core/constants/app_colors.dart';
import 'package:vet_mkononi/core/widgets/app_text_styles.dart';
import 'package:vet_mkononi/features/farmer/domain/entities/farmer.dart';

typedef OnEditCallback = void Function();
typedef OnDeleteCallback = void Function();

class CustomBottomSheetWidget extends StatelessWidget {
  final Farmer farmer;
  final OnEditCallback onEdit;
  final OnDeleteCallback onDelete;

  const CustomBottomSheetWidget({
    super.key,
    required this.farmer,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: AppColors.subHeading),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Center(child: Text('Quick actions', style: AppTextStyles.title)),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                onEdit();
              },
              child: Text('Update farmer details', style: TextStyle(color: AppColors.secondary, fontSize: 16.0)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                onDelete();
              },
              child: const Text('Delete farmer', style: TextStyle(color: Colors.redAccent, fontSize: 16.0)),
            ),
          ],
        ),
      ),
    );
  }
}
