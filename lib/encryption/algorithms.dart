import 'dart:developer';

import 'package:encrypt/encrypt.dart';
import 'package:nize_gallery/constants/constants.dart';

class Algorithm {
  String aesEncryption(String text) {
    final key = Key.fromUtf8(utf8Key);
    final iv = IV.allZerosOfLength(16);

    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(text, iv: iv);
    log('enc: ' + encrypted.base64.toString());
    return encrypted.base64;
  }

  String aesDecrytion(String encryptedText) {
    final key = Key.fromUtf8(utf8Key);
    final iv = IV.allZerosOfLength(16);

    final encrypter = Encrypter(AES(key));
    final decrypted =
        encrypter.decrypt(Encrypted.fromBase64(encryptedText), iv: iv);
    log('decrypted: ' + decrypted);
    return decrypted;
  }
}
