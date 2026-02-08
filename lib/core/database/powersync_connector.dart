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
  Future<void> uploadData(PowerSyncDatabase database) async {
    // 3. Get the next batch of offline changes (transactions)
    final transaction = await database.getNextCrudTransaction();
    if (transaction == null) return;

    try {
      // 4. Iterate through every change (Insert, Update, Delete)
      for (var op in transaction.crud) {
        final table = op.table;
        final data = op.opData;
        final id = op.id;

        // 5. Use Supabase SDK to apply changes to the Cloud
        if (op.op == UpdateType.put) {
          // 'put' means Insert or Update (Upsert)
          // We must remove 'id' from data if it exists to avoid duplication in the payload,
          // though Supabase handles it well usually.
          var payload = Map<String, dynamic>.from(data!);
          payload['id'] = id; // Ensure ID is present

          await _supabase.from(table).upsert(payload);
        } else if (op.op == UpdateType.patch) {
          // 'patch' means Update specific fields
          await _supabase.from(table).update(data!).eq('id', id);
        } else if (op.op == UpdateType.delete) {
          // 'delete' means remove the row
          await _supabase.from(table).delete().eq('id', id);
        }
      }

      // 6. If successful, tell PowerSync to remove these from the queue
      await transaction.complete();
    } catch (e) {
      // If upload fails (e.g., Trial Limit Reached), we log it.
      // PowerSync will keep it in the queue and retry later.
      if (dotenv.env['APP_STATUS'] == 'DEVELOPMENT') {
        print('Sync Upload Error: $e');
      }

      // Optional: You could throw a specific exception here to notify UI
      // but usually we just let it retry.
      rethrow;
    }
  }
}
