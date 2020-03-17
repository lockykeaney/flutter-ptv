#008CCE

I am trying to make an app that consumes my cities public transport data to practice my Flutter development. It requires a signature that is a HMAC-SHA1 hash of the completed request.

The entire explanation from the documentation is:

```
The signature value is a HMAC-SHA1 hash of the completed request (minus the base URL but including your user ID, known as “devid”) and the API key:
•	signature	=	crypto.HMACSHA1(request,key)
The calculation of a signature is based on a case-sensitive reading of the request message. This means that the request message used to calculate the signature must not be modified later on in your code or the signature will not work. If you do modify the case of the request message, you will need to calculate a new signature.
For example, “http://timetableapi.ptv.vic.gov.au/v2/healthcheck?devid=ABCXYZ” and “http://timetableapi.ptv.vic.gov.au/v2/HealthCheck?devid=ABCXYZ” require different signatures to be calculated; the same signature will not work for both requests.
The signature itself is also case-sensitive
```

The examples that come with it are in languages that I have no experience with, the closest being python, which has an example like this:

```
from hashlib import sha1
import hmac
import binascii
def getUrl(request):
    devId = 2
    key = '7car2d2b-7527-14e1-8975-06cf1059afe0'
    request = request + ('&' if ('?' in request) else '?')
    raw = request+'devid={0}'.format(devId)
    hashed = hmac.new(key, raw, sha1)
    signature = hashed.hexdigest()
    return 'http://tst.timetableapi.ptv.vic.gov.au'+raw+'&signature={1}'.format(devId, signature)

print getUrl('/v2/healthcheck')
```

I don't understand what is happening in the raw variable, is the format function the same as a `utf8.encode(string)` function (found below)?

I have already installed the crypto package for dart, and have tried to copy this example from the readme:

```
import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() {
  var key = utf8.encode('p@ssw0rd');
  var bytes = utf8.encode("foobar"); //

  var hmacSha256 = new Hmac(sha256, key); // HMAC-SHA256
  var digest = hmacSha256.convert(bytes);

  print("HMAC digest as bytes: ${digest.bytes}");
  print("HMAC digest as hex string: $digest");
}
```

The hashed value in the python example takes in 3 arguments, which is then digested for the signature. The dart package only takes in the 2, a hash and a key. How can I make the hash for the url, if it is `http://timetableapi.ptv.vic.gov.au/v3/routes?devid=$id&signature=$digest` for example;

I have tried this:

```
var id = 'xxxxx';
var key = utf8.encode('xxxxx');
var request = utf8.encode("routes?devid=$id");

var hmacSha1 = new Hmac(sha1, key); // HMAC-SHA1
var digest = hmacSha1.convert(request);
```

Where I have a has from the key, and then try and convert the request using that.

This is more of a question about hashing itself, as it is not something I am very familiar with, this is actually the first time I have needed to do it, but if anyone is willing to give me some spark notes I'd really appreciate that.

Thank you in advance.
