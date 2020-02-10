import 'dart:convert';
import 'package:crypto/crypto.dart';

String service(String requestArg) {
  var id = 3001376;
  var key = utf8.encode('a038ac1d-33d2-4dbf-a1a7-8e435a3e06ec');
  var request = utf8.encode("/v3/$requestArg?devid=$id");
  var hmacSha1 = new Hmac(sha1, key); // HMAC-SHA1
  var digest = hmacSha1.convert(request);
  return 'http://timetableapi.ptv.vic.gov.au/v3/$requestArg?devid=$id&signature=$digest';
}
