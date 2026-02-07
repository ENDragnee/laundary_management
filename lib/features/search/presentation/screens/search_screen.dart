import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  // Use BehaviorSubject for debouncing user input to avoid excessive DB queries
  final _querySubject = BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _querySubject.add(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _querySubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final database = context.read<AppDatabase>();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search by name, phone, or code...',
            border: InputBorder.none,
          ),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: StreamBuilder<List<LaundryOrder>>(
        // Debounce to wait for user to stop typing before querying the database
        stream: _querySubject.stream
            .debounceTime(const Duration(milliseconds: 300))
            .switchMap((query) => database.searchOrders(query)),
        builder: (context, snapshot) {
          if (_searchController.text.trim().isEmpty) {
            return const Center(child: Text('Start typing to search.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting &&
              _querySubject.hasValue) {
            return const Center(child: CircularProgressIndicator());
          }
          final orders = snapshot.data ?? [];
          if (orders.isEmpty) {
            return const Center(child: Text('No matching orders found.'));
          }
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(order.customerName),
                  subtitle: Text(
                    'Code: ${order.code} | Phone: ${order.phoneNumber}',
                  ),
                  trailing: Text('\$${order.totalPrice.toStringAsFixed(2)}'),
                  onTap: () => context.push('/order_form', extra: order),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
