// Minimal PoC: Simulates the vulnerable wallet key loading

class KeyPair {
  final String publicKey;
  final String privateKey;
  KeyPair(this.publicKey, this.privateKey);
}

class NodeKeyCache {
  KeyPair? _keyPair;

  void setKeyPair(KeyPair keyPair) {
    _keyPair = keyPair;
    print("[DEBUG] Keys cached in memory!");
  }
}

class RSA {
  static Future<String> convertPrivateKeyToPublicKey(String privateKey) async {
    // Fake derivation for PoC
    return "FAKE_PUBLIC_KEY_DERIVED_FROM_PRIVATE_KEY";
  }
}

final _nodeKeyCache = NodeKeyCache();

Future<void> loadWalletSigningKey(String privateKey) async {
  final publicKey = await RSA.convertPrivateKeyToPublicKey(privateKey);
  _nodeKeyCache.setKeyPair(KeyPair(publicKey, privateKey));
}

void main() async {
  const testPrivateKey = """
-----BEGIN RSA PRIVATE KEY-----
MIIBOgIBAAJBALf7uVv8vFxuVzK7HUlxFAKETCk1234567890EXAMPLEKEYDATA
-----END RSA PRIVATE KEY-----
""";

  await loadWalletSigningKey(testPrivateKey);

  print("Key loaded. Process is now idling for 5 minutes...");
  print("You can now search the process memory for the private key.");
  await Future.delayed(Duration(minutes: 60));
}