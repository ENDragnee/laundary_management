import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:laundary_management/core/constants/order_status.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:laundary_management/features/laundry_order/presentation/models/clothing_item.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class OrderFormScreen extends StatefulWidget {
  final LaundryOrder? order;
  const OrderFormScreen({super.key, this.order});

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _priceController;
  late DateTime _dueDate;
  late OrderStatus _status;
  late List<ClothingItem> _clothingItems;
  bool _hasChanges = false;

  bool get _isEditing => widget.order != null;

  @override
  void initState() {
    super.initState();
    final order = widget.order;
    _nameController = TextEditingController(text: order?.customerName ?? '');
    _phoneController = TextEditingController(text: order?.phoneNumber ?? '');
    _priceController = TextEditingController(
      text: order?.totalPrice.toString() ?? '0.0',
    );
    _dueDate = order?.dueDate ?? DateTime.now().add(const Duration(days: 3));
    _status = order != null
        ? OrderStatus.values[order.status]
        : OrderStatus.pending;
    _clothingItems = order != null
        ? ClothingItem.decode(order.clothes)
        : [ClothingItem()];

    _nameController.addListener(() => _hasChanges = true);
    _phoneController.addListener(() => _hasChanges = true);
    _priceController.addListener(() => _hasChanges = true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
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
    if (!mounted) return;
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
        _hasChanges = true;
      });
    }
  }

  Future<void> _saveOrder() async {
    if (_formKey.currentState!.validate()) {
      final database = context.read<AppDatabase>();
      final messenger = ScaffoldMessenger.of(context);
      final router = GoRouter.of(context);

      final now = DateTime.now();
      final orderCompanion = LaundryOrdersCompanion(
        id: _isEditing ? d.Value(widget.order!.id) : const d.Value.absent(),
        customerName: d.Value(_nameController.text),
        phoneNumber: d.Value(_phoneController.text),
        clothes: d.Value(ClothingItem.encode(_clothingItems)),
        totalPrice: d.Value(double.tryParse(_priceController.text) ?? 0.0),
        dueDate: d.Value(_dueDate),
        status: d.Value(_status.index),
        code: _isEditing
            ? d.Value(widget.order!.code)
            : d.Value(const Uuid().v4().substring(0, 6).toUpperCase()),
        createdAt: _isEditing ? d.Value(widget.order!.createdAt) : d.Value(now),
        updatedAt: d.Value(now),
      );

      try {
        if (_isEditing) {
          await database.updateOrder(orderCompanion);
        } else {
          await database.addOrder(orderCompanion);
        }

        if (!mounted) return;

        messenger.showSnackBar(
          SnackBar(
            content: Text(
              'Order ${_isEditing ? 'updated' : 'saved'} successfully!',
            ),
          ),
        );
        router.pop();
      } catch (error) {
        if (!mounted) return;
        messenger.showSnackBar(
          SnackBar(content: Text('Failed to save order: $error')),
        );
      }
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
            onPressed: () async {
              final database = context.read<AppDatabase>();
              final messenger = ScaffoldMessenger.of(context);
              final router = GoRouter.of(context);
              final dialogNavigator = Navigator.of(ctx);

              await database.deleteOrder(widget.order!.id);

              if (!mounted) return;

              dialogNavigator.pop();
              router.pop();
              messenger.showSnackBar(
                const SnackBar(content: Text('Order deleted successfully!')),
              );
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

  void _addClothingItem() {
    setState(() {
      _clothingItems.add(ClothingItem());
      _hasChanges = true;
    });
  }

  void _removeClothingItem(int index) {
    setState(() {
      _clothingItems.removeAt(index);
      _hasChanges = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Unsaved Changes'),
            content: const Text(
              'You have unsaved changes. Are you sure you want to leave?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Stay'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Leave'),
              ),
            ],
          ),
        );
        if (!context.mounted) return;
        if (shouldPop ?? false) {
          context.pop();
        }
      },
      child: Scaffold(
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
                if (_isEditing) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Code',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.order!.code,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: widget.order!.code),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Code copied to clipboard'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Customer Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Please enter a name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.trim().isEmpty
                      ? 'Please enter a phone number'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Total Price',
                    suffixText: 'ETB',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'Clothes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ..._clothingItems.asMap().entries.map((entry) {
                  int idx = entry.key;
                  ClothingItem item = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            initialValue: item.name,
                            onChanged: (val) {
                              item.name = val;
                              _hasChanges = true;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Item Name',
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            initialValue: item.quantity.toString(),
                            onChanged: (val) {
                              item.quantity = int.tryParse(val) ?? 1;
                              _hasChanges = true;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Quantity',
                              isDense: true,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => _removeClothingItem(idx),
                        ),
                      ],
                    ),
                  );
                }),
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Item'),
                  onPressed: _addClothingItem,
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
                const SizedBox(height: 24),
                DropdownButtonFormField<OrderStatus>(
                  initialValue: _status,
                  decoration: const InputDecoration(
                    labelText: 'Order Status',
                    border: OutlineInputBorder(),
                  ),
                  items: OrderStatus.values.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status.displayName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _status = value;
                        _hasChanges = true;
                      });
                    }
                  },
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
      ),
    );
  }
}
