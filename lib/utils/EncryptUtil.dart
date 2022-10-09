import 'package:encrypt/encrypt.dart';
import 'package:steel_crypt/steel_crypt.dart';

class EncryptUtil {


  static String aesEncode(String secretKey, String content) {
    Key key = Key.fromUtf8(secretKey);
    return Encrypter(AES(key,mode: AESMode.ecb)).encrypt(content, iv: IV.fromUtf8("")).base64;
  }

  static String aesDecode(String secretKey, String content) {
    return AesCrypt(padding: PaddingAES.pkcs7, key: secretKey).ecb.decrypt(enc: content);
  }
}
