
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vet_mkononi/features/farmer/domain/entities/farmer.dart';
import 'package:vet_mkononi/features/farmer/presentation/providers/farmer_provider.dart';

class EditFarmerScreen extends ConsumerStatefulWidget {
  final Farmer farmer;

  const EditFarmerScreen({super.key, required this.farmer});

  @override
  ConsumerState<EditFarmerScreen> createState() => _EditFarmerScreenState();
}

class _EditFarmerScreenState extends ConsumerState<EditFarmerScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _locationController;
  late final TextEditingController _msisdnController;
  late final TextEditingController _farmNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.farmer.firstName);
    _locationController = TextEditingController(text: widget.farmer.location);
    _msisdnController = TextEditingController(text: widget.farmer.msisdn);
    _farmNameController = TextEditingController(text: widget.farmer.farmName);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _locationController.dispose();
    _msisdnController.dispose();
    _farmNameController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final updatedMap = {
        "id": widget.farmer.id,
        "first_name": _firstNameController.text.trim(),
        "location": _locationController.text.trim(),
        "msisdn": _msisdnController.text.trim(),
        "farm_name": _farmNameController.text.trim(),
        "org_id": "",
      };

      try {
        await ref.read(updateFarmerProvider).call(updatedMap);
        ref.invalidate(farmerListProvider);

        final updatedFarmer = Farmer(
          id: widget.farmer.id,
          firstName: _firstNameController.text.trim(),
          location: _locationController.text.trim(),
          msisdn: _msisdnController.text.trim(),
          farmName: _farmNameController.text.trim(),
        );

        if (mounted) Navigator.of(context).pop(updatedFarmer);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update farmer: $e")),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Farmer")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _msisdnController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _farmNameController,
                decoration: const InputDecoration(labelText: 'Farm Name'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Update Farmer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
