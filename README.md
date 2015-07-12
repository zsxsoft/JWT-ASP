JWT-ASP
=======

JSON Web Tokens implemented in ASP JScript.

Forked from https://github.com/michaelrhanson/jwt-js

## Installion

Copy ``build/jwt.all.asp`` or ``jwt.all.jscript.asp`` to your website, then include it.

In JScript: 
```asp
<!-- #include file="jwt.all.jscript.asp" -->
```

In VBScript:
```asp
<!-- #include file="jwt.all.asp" -->
```

## Usage

By JScript: 
```javascript
<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<!--#include file="build/jwt.all.jscript.asp" -->
<%
function getJwt(){
  var token = new jwt.WebToken('{"iss": "joe", "exp": 1300819380, "http://example.com/is_root": true}', '{"typ":"JWT", "alg":"HS256"}');
  var signed = token.serialize("Key");
  return signed;
}
Response.Write(getJwt());
%>
```

By VBScript:
```asp
<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="build/jwt.all.asp" -->
<%
Response.Write GetJwt()
%>

<script language="javascript" runat="server">
function getJwt(){
  var token = new jwt.WebToken('{"iss": "joe", "exp": 1300819380, "http://example.com/is_root": true}', '{"typ":"JWT", "alg":"HS256"}');
  var signed = token.serialize("Key");
  return signed;
}
</script>
```

If you want to encode some non-ASCII characters, you should use function ``JSONencode()`` (was also contained in jwt.all*.asp) written by Tuðrul Topuz to encode it first. For example:
```javascript
var token = new jwt.WebToken('{"name": "'+JSONencode("你好世界")+'"}', "{\"typ\":\"JWT\",\"alg\":\"HS256\"}");
```

For other usage, see ``tests/index.asp``.

## Supported algorithm

### Test Encodings
HS256  / ES256 / RS256

### Test Digest Functions

SHA256

### Test Signature Generation / Verification

HMAC-SHA256 / RSA-SHA256

## Test

Fork this project, copy all files to your IIS website. Then open ``/YOUR_COPIED_PATH/tests/`` in your browser.

## Known Issue

* The RSA-SHA256 algorithm will full your CPU.
* RSA-SHA384/512 / HMAC-SHA384/512 / ECDSA-SHA384/512 is unsupported.

## License

MPL1.1 / GPL2.0 / LGPL2.1

