import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vet_mkononi/core/constants/app_colors.dart';
import 'package:vet_mkononi/core/widgets/app_text_input_widget.dart';
import 'package:vet_mkononi/core/widgets/app_text_styles.dart';
import 'package:vet_mkononi/features/farmer/domain/entities/farmer.dart';
import 'package:vet_mkononi/features/farmer/presentation/providers/farmer_provider.dart';
import 'package:vet_mkononi/features/farmer/presentation/widgets/farmer_tile.dart';

import 'edit_farmer_screen.dart';
import 'farmer_details_screen.dart';
import 'farmer_form_screen.dart';

class FarmerListScreen extends ConsumerStatefulWidget {
  const FarmerListScreen({super.key});

  @override
  ConsumerState<FarmerListScreen> createState() => _FarmerListScreenState();
}

class _FarmerListScreenState extends ConsumerState<FarmerListScreen> {
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  Future<void> _deleteFarmer(BuildContext context, String farmerId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Delete Farmer'),
            content: const Text('Are you sure you want to delete this farmer?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      try {
        await ref.read(deleteFarmerProvider)(farmerId);
        ref.invalidate(farmerListProvider);
        //if (mounted) Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Delete failed: $e")));
      }
    }
  }

  Future<void> _navigateToEdit(Farmer farmer) async {
    final result = await Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: EditFarmerScreen(farmer: farmer),
      ),
    );

    if (result != null) {
      ref.invalidate(farmerListProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final farmers = ref.watch(farmerListProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My farmers', style: AppTextStyles.title),
                Text('1 Available', style: AppTextStyles.subheading),
              ],
            ),
            const SizedBox(height: 20.0),
            AppTextInputWidget(
              controller: searchController,
              hintText: 'Search by name or location',
              prefixIcon: Icons.search,
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: farmers.when(
                data: (list) {
                  final filteredList =
                      list.where((farmer) {
                        final name =
                            '${farmer.firstName} ?? ''}'
                                .toLowerCase();
                        final location = farmer.location.toLowerCase();
                        return name.contains(searchQuery) ||
                            location.contains(searchQuery);
                      }).toList();

                  if (filteredList.isEmpty) {
                    return const Center(child: Text('No farmers found.'));
                  }

                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final farmer = filteredList[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: FarmerDetailsScreen(farmer: farmer),
                              duration: const Duration(milliseconds: 300),
                            ),
                          );
                        },
                        child: FarmerTile(
                          farmer: farmer,
                          onEdit: () {
                            _navigateToEdit(farmer);
                          },
                          onDelete: () {
                            _deleteFarmer(context, farmer.id);
                          },
                        ),
                      );
                    },
                  );
                },
                loading:
                    () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: InkWell(
          onTap: (){
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                child: const FarmerFormScreen(),
                duration: const Duration(milliseconds: 300),
              ),
            );
          },
          child: Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: AppColors.primary
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.plus, color: AppColors.appWhite, size: 16.0,),
                const SizedBox(width: 5.0,),
                Text("New farmer", style: TextStyle(color: AppColors.appWhite, fontSize: 16.0),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
