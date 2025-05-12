import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vet_mkononi/core/constants/app_colors.dart';
import 'package:vet_mkononi/core/widgets/app_text_styles.dart';
import 'package:vet_mkononi/features/farmer/domain/entities/farmer.dart';
import 'package:vet_mkononi/features/farmer/presentation/providers/farmer_provider.dart';
import 'package:vet_mkononi/main.dart';

import 'edit_farmer_screen.dart';

class FarmerDetailsScreen extends ConsumerStatefulWidget {
  final Farmer farmer;

  const FarmerDetailsScreen({super.key, required this.farmer});

  @override
  ConsumerState<FarmerDetailsScreen> createState() => _FarmerDetailsScreenState();
}

class _FarmerDetailsScreenState extends ConsumerState<FarmerDetailsScreen> {
  late Farmer farmer;

  @override
  void initState() {
    super.initState();
    farmer = widget.farmer;
  }

  Future<void> _navigateToEdit() async {
    final result = await Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: EditFarmerScreen(farmer: farmer),
      ),
    );

    if (result != null && result is Farmer) {
      setState(() {
        farmer = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.only(right: 10),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.share, size: 20.0,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(farmer.farmName, style: AppTextStyles.subheadingA1,),
                      Text(farmer.location, style: TextStyle(color: AppColors.subHeading,),),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(
              textAlign: TextAlign.start,
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do\n eiusmod tempor incididunt ut labore\n et dolore magna aliqua.', style: TextStyle(
              color: AppColors.subHeading,

            ),),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: (){

              },
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.link, color: Colors.redAccent, size: 12.0),
                  const SizedBox(width: 10.0,),
                  Text('Call farmer', style: TextStyle(color: Colors.redAccent),)
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              height: 90.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(farmer.balance.toString(), style: AppTextStyles.title,),
                        const SizedBox(height: 3.0,),
                        Text('Balance', style: TextStyle(color: AppColors.subHeading),)
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('5', style: AppTextStyles.title,),
                        const SizedBox(height: 3.0,),
                        Text('Requests', style: TextStyle(color: AppColors.subHeading),)
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('100', style: AppTextStyles.title,),
                        const SizedBox(height: 3.0,),
                        Text('Payout', style: TextStyle(color: AppColors.subHeading),)
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('10', style: AppTextStyles.title,),
                        const SizedBox(height: 3.0,),
                        Text('Activities', style: TextStyle(color: AppColors.subHeading),)
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0,),

            ElevatedButton(
              onPressed: _navigateToEdit,
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Edit Farmer'),
            ),
            const SizedBox(height: 15.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete Farmer'),
                    content: const Text('Are you sure you want to delete this farmer?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                      TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
                    ],
                  ),
                );

                if (confirm == true) {
                  try {
                    await ref.read(deleteFarmerProvider)(farmer.id);
                    ref.invalidate(farmerListProvider);
                    if (mounted) Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Delete failed: $e")),
                    );
                  }
                }
              },
              child: const Text('Delete Farmer', style: TextStyle(color: AppColors.appWhite),),
            ),
          ],
        ),
      ),
    );
  }
}