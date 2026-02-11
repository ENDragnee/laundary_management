import 'dart:convert'; // Required for jsonDecode
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:powersync/powersync.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConnector extends PowerSyncBackendConnector {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<PowerSyncCredentials?> fetchCredentials() async {
    final session = _supabase.auth.currentSession;
    if (session == null) return null;
    return PowerSyncCredentials(
      endpoint: dotenv.env['POWERSYNC_URL']!,
      token: session.accessToken,
    );
  }

  @override
  Future<void> uploadData(PowerSyncDatabase database) async {
    final transaction = await database.getNextCrudTransaction();
    if (transaction == null) return;

    try {
      for (var op in transaction.crud) {
        final table = op.table;
        final id = op.id;
        var data = op.opData ?? {};

        // FIX 1: Handle JSONB conversion for 'clothes' column
        // Drift stores it as String, Supabase wants a JSON Object
        if (data.containsKey('clothes') && data['clothes'] is String) {
          try {
            data['clothes'] = jsonDecode(data['clothes'] as String);
          } catch (e) {
            // If it's not valid JSON, leave it or handle error
          }
        }

        if (op.op == UpdateType.put) {
          // IMPORTANT: Upsert needs the ID
          data['id'] = id;
          await _supabase.from(table).upsert(data);
        } else if (op.op == UpdateType.patch) {
          await _supabase.from(table).update(data).eq('id', id);
        } else if (op.op == UpdateType.delete) {
          await _supabase.from(table).delete().eq('id', id);
        }
      }
      await transaction.complete();
    } catch (e) {
      rethrow;
    }
  }
}
