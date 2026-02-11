import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShopSettingsScreen extends StatefulWidget {
  const ShopSettingsScreen({super.key});

  @override
  State<ShopSettingsScreen> createState() => _ShopSettingsScreenState();
}

class _ShopSettingsScreenState extends State<ShopSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _loadCurrentData();
  }

  Future<void> _loadCurrentData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final database = context.read<AppDatabase>();
    final profile = await database.getLaundryProfile(user.id);

    if (profile != null) {
      setState(() {
        _nameController.text = profile.name ?? '';
        _phoneController.text = profile.phoneNumber ?? '';
      });
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final user = Supabase.instance.client.auth.currentUser;
    final database = context.read<AppDatabase>();

    try {
      await database.updateLaundryProfile(
        LaundriesCompanion(
          id: d.Value(user!.id),
          name: d.Value(_nameController.text.trim()),
          phoneNumber: d.Value(_phoneController.text.trim()),
          updatedAt: d.Value(DateTime.now().toIso8601String()),
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings updated successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Shop Information',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Shop Name',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Shop Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _updateProfile,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
