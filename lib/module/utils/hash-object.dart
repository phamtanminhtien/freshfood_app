import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashObject(Map<String, dynamic> object) {
  final stringified = json.encode(object);
  final bytes = utf8.encode(stringified);
  final hash = sha256.convert(bytes);
  return hash.toString();
}

bool verifyHash(String hash1, String hash2) {
  if (hash1 != hash2) {
    return false;
  }
  return true;
}
