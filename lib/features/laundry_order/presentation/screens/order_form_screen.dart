import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class OrderFormScreen extends StatefulWidget {
  // If an order is passed, we are in "edit" mode.
  final LaundryOrder? order;

  const OrderFormScreen({super.key, this.order});

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _clothesController;
  late TextEditingController _priceController;
  late DateTime _dueDate;

  bool get _isEditing => widget.order != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.order?.customerName ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.order?.phoneNumber ?? '',
    );
    _clothesController = TextEditingController(
      text: widget.order?.clothes ?? '',
    );
    _priceController = TextEditingController(
      text: widget.order?.totalPrice.toString() ?? '',
    );
    _dueDate =
        widget.order?.dueDate ?? DateTime.now().add(const Duration(days: 3));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _clothesController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  void _saveOrder() {
    if (_formKey.currentState!.validate()) {
      final database = context.read<AppDatabase>();
      final now = DateTime.now();

      final orderCompanion = LaundryOrdersCompanion(
        id: _isEditing ? d.Value(widget.order!.id) : const d.Value.absent(),
        customerName: d.Value(_nameController.text),
        phoneNumber: d.Value(_phoneController.text),
        clothes: d.Value(_clothesController.text),
        totalPrice: d.Value(double.tryParse(_priceController.text) ?? 0.0),
        dueDate: d.Value(_dueDate),
        code: _isEditing
            ? d.Value(widget.order!.code)
            : d.Value(const Uuid().v4().substring(0, 6).toUpperCase()),
        createdAt: _isEditing ? d.Value(widget.order!.createdAt) : d.Value(now),
        updatedAt: d.Value(now),
      );

      if (_isEditing) {
        database.updateOrder(orderCompanion);
      } else {
        database.addOrder(orderCompanion);
      }

      context.pop();
    }
  }

  void _deleteOrder() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this order?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AppDatabase>().deleteOrder(widget.order!.id);
              // Pop twice to exit the dialog and the form screen
              Navigator.of(ctx).pop();
              context.pop();
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Order' : 'New Order'),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _deleteOrder,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Customer Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a phone number' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Total Price'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a price' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _clothesController,
                decoration: const InputDecoration(
                  labelText: 'Clothes (e.g., 5 shirts, 2 pants)',
                ),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Please list the clothes' : null,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Due Date: ${DateFormat.yMMMd().format(_dueDate)}',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDueDate(context),
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveOrder,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Text(_isEditing ? 'Update Order' : 'Save Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
