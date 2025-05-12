import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vet_mkononi/features/farmer/presentation/providers/farmer_provider.dart';

class FarmerFormScreen extends ConsumerStatefulWidget {
  const FarmerFormScreen({super.key});

  @override
  ConsumerState<FarmerFormScreen> createState() => _FarmerFormScreenState();
}

class _FarmerFormScreenState extends ConsumerState<FarmerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _msisdnController = TextEditingController();
  final _farmNameController = TextEditingController();
  final _balanceController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _locationController.dispose();
    _msisdnController.dispose();
    _farmNameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final data = {
        "first_name": _firstNameController.text.trim(),
        "location": _locationController.text.trim(),
        "msisdn": _msisdnController.text.trim(),
        "org_id": "",
        "farm_name": _farmNameController.text.trim(),
        "existing_balance": double.tryParse(_balanceController.text.trim()) ?? 0
      };

      try {
        await ref.read(addFarmerProvider).call(data);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Farmer added successfully')),
          );
          Navigator.pop(context);
          ref.invalidate(farmerListProvider);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Farmer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _msisdnController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _farmNameController,
                decoration: const InputDecoration(labelText: 'Farm Name'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _balanceController,
                decoration: const InputDecoration(labelText: 'Balance'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
