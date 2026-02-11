import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:powersync/powersync.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConnector extends PowerSyncBackendConnector {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<PowerSyncCredentials?> fetchCredentials() async {
    // 1. Get the current session from Supabase Auth
    final session = _supabase.auth.currentSession;

    // If no one is logged in, we can't sync
    if (session == null) return null;

    // 2. Return credentials using the token and URL from .env
    return PowerSyncCredentials(
      endpoint: dotenv.env['POWERSYNC_URL']!,
      token: session.accessToken,
    );
  }

  @override
  @override
  Future<void> uploadData(PowerSyncDatabase database) async {
    final transaction = await database.getNextCrudTransaction();
    if (transaction == null) return;

    try {
      for (var op in transaction.crud) {
        final table = op.table;
        final data = op.opData;
        final id = op.id;

        if (op.op == UpdateType.put) {
          final payload = Map<String, dynamic>.from(data!);
          payload['id'] = id;

          // Print for debugging
          print('Attempting Sync: UPSERT on $table for ID $id');

          final res = await _supabase.from(table).upsert(payload).select();
          print('Sync Success: $res');
        } else if (op.op == UpdateType.patch) {
          await _supabase.from(table).update(data!).eq('id', id as Object);
        } else if (op.op == UpdateType.delete) {
          await _supabase.from(table).delete().eq('id', id as Object);
        }
      }
      await transaction.complete();
    } catch (e) {
      // THIS IS THE MOST IMPORTANT PRINT
      print('CRITICAL SYNC ERROR: $e');
      rethrow;
    }
  }
}
