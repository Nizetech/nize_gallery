import 'package:encrypt/encrypt.dart';
import 'package:nize_gallery/constants/constants.dart';

class Algorithm {
  static Encrypted aesEncryption(String text) {
    final key = Key.fromUtf8(utf8Key);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted;
  }

  static String aesDecrytion(Encrypted text) {
    final key = Key.fromUtf8(utf8Key);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));
    // final encrypted = encrypter.encrypt(text, iv: iv);
    final decrypted = encrypter.decrypt(text, iv: iv);
    return decrypted;
  }
}
