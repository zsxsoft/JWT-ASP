<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<!-- #include file="..\src\jwt.asp" -->
<!--
 * Automated tests for jwt-js, pure JavaScript implementation of JSON Web Tokens.
 * Copyright (c) 2011, Michael Hanson, mhanson@mozilla.com
 * See README for licensing data.
 *
 * Based on and translated from Java-based unit tests for WebTokenTests by AxelNennker,
 * license notice follows:
 *
 * Copyright (c) 2011, Axel Nennker - http://axel.nennker.de/
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the names xmldap, xmldap.org, xmldap.com nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->

<html>
<head>
<title>JSON Web Token Tests</title>
<!-- This stylesheet is optional, but does improve the output: -->
<link rel="stylesheet" type="text/css" href="doctest.css" />
<style type="text/css">
body {
	font-family: sans-serif;
}
</style>
<%
var joeStr = "{\"iss\":\"joe\",\r\n" + " \"exp\":1300819380,\r\n" + " \"http://example.com/is_root\":true}";
var hs256 = "{\"typ\":\"JWT\",\r\n"+
                 " \"alg\":\"HS256\"}";
var hs384 = "{\"typ\":\"JWT\",\r\n"+
                 " \"alg\":\"HS384\"}";
var hs512 = "{\"typ\":\"JWT\",\r\n"+
                 " \"alg\":\"HS512\"}";

var hsKey = [3, 35, 53, 75, 43, 15, 165, 188, 131, 126, 6, 101, 119, 123, 166, 143, 90, 179, 40, 230, 240, 84, 201, 40, 169, 15, 132, 178, 210, 80, 46, 191, 211, 251, 90, 146, 210, 6, 71, 239, 150, 138, 180, 195, 119, 98, 61, 34, 61, 46, 33, 114, 5, 46, 79, 8, 192, 205, 154, 245, 103, 208, 128, 163];
var rsKeyPEM = Base64Encoder.decode("LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBeEV5bWpsbVBNVXN2RTVQVStBVFNOd2c0dkxtS2tEMzFTRzI4WkRuN0RoNmMxT0FoCllYL3lFcCs1QlhxOHliQmtScGZDLzdzclJRNCtUeG5uR3NwUHQvZVF5S2ZORjgwbHd5NFRSQS9TYlJDallmK04KVHE2ZTh2M1FIOE05U2NpS01HME9MbXZNbk9nVi9tVFJVd1pTdUxPZXRaTEQxNmdDZ2QxR0cwc01BS0JYYkpaZwoyb3oxdEp1bFBPdGFDWW1ReHU1M2NWSGtmRHZGLzRLMG1LMTIyam8xRnh4UGtBbjNOcU1Db2QzR3hpOFVIaE5iCjBzOHhsVzl6Ynlvc2RmdGJqOWI1VGRCTXBSUzlmRWllc1psQVpxOGtPa1lUUnJVVHJZdjI1d2pYaEhCSGNOeUsKVEhDbjVYZGl2dTdzZFBMZVBEajhuSFJuTGo0cmtTaktwaUZHYXdJREFRQUJBb0lCQVFDZDVib2p6czVyckRwVgoyUmY1MklidlZXR3VET0QwWGFJcmZIbUpkVW9JZFg5WmpGL05lWWxTaWIvZU5IZ2ZGQS9VNk1ZbHhueHJzNlZUCkkxYk9LZVl0NktsQmZoaHZDTWxUVW9DVXd0VlVmWW11amswditTNUo3dmUyVk9tN3E5L2NUQnlZSW9ZWHdHZlEKbFcvN0JKOE5pdzRpcDhkNGRPQnZiWG16QW83SkFNZERBTXdDZlNPTFBwRVprMXdsc1Q5YjBHaHZnMHZsVU5oTwpISGRmSjYzRlRyY2xZUFZETXNuNmU1aEZOSXRCenVQeDlvUjN2eENmQjQyZkY5TVpYRnpIamx0NUd1Q0hqOUN0CkJ4UlJxdENsb1JLR3V1ak9DUkEzM1NaS3p3Snd2KzkzZkxZVkh0anBYOGsvczhjYkpFcFVzdDlxdGxZTmoxSFoKMmc2Q0t0QkJBb0dCQVBEQ0o4R20wYjQ2Y0FiLzY3MXMxeFJJYnRDbjZxSEtwVHFwN1RJT2FxajlOQWJqeDFrYgozTUJ1MUc4OVZzMFRvOWlZejB2M1VZcUMyZ0kzTnd2SEtZZTBReENaVE84Y2kvaVRxa3ZsbXZNbG1XK2ZwQnlRCmhzay8vTXMzQlcvM0VNRVhiUklLNXA3akFMa2ZyemVqY0pIeG5scTkzdlJob2lSZUsrMWVqTEVqQW9HQkFOQzUKK01HNU5wZnJjaUR0akhQelp5YlRUd0t2b0wzVEpvMWNESHJaaE5nWWNUOTgrSkM1bzcwWTIvSXprcHZPUmFuagpiUEIrcEhFM2ZYZ0dHVHFESGNtbyt2RnQ4MkZvRGVMdmRRb0NJblduMzJtTUlvQUthdE8zM3oreUFmcjg2eUZOCjIzdlNQL0JndXBrVEYvZ0ltY3QvK2tlWU12WDB6KzhsUVR6eUpMNFpBb0dBVldhWmthQ3AvODljMDY3T0lXaE4KTnIybXlVNzI5S01jVHgzZHJJYmVvTWtJUG5WbnpoMExCaHVLTVZkUnhmYjBoSzFYd3Z1Y3FnUldicmpGUnVGRAp3d1pYVDdrQlNFUVpCbmppekg5S29uc3czUjZFcVRrL0JuNHpIcWFLd0Rla2NzbnJmNTNzUm1vQlpLbHZqczNqCjdYRUdtZXVGL2F2d1J2UThvcnVLTG44Q2dZQTM0b01yQXpjTngvbGZ2WnFNZFJBYVFodDJnYVdORFpyVjRGNXIKQ2hCYWQzamk0Y2YvbitTcVBaeXVKWWJNZHBjS1hKMFBheWtHTXpCQjBZZ3h0V2RsVmZ3U1pqanl6SlJqUFcvZAp4U0tLMCs2cWFOM1g0SElueTZSWGZvYXZOOGFRdlRMVjNUNUhVdTdEQzJ5d2VVVU1TbkN0ZUorMFlON0hqZmNBCnBXaVhDUUtCZ0N5SDVETTFWb1NNaCtVSXJ6WW5vVVVKY1ZDL3EyWGp0Zkdod3JhVUJhTTZ6OVNXaFg2amZMSGkKNW9qc2ZjSE5vU3h5a0hJQllXNmovQ1ZVSmpoY2NRa0pnR2tHRmoxZkh2cTVpWGZPaTFjMWl6djQxQ0REWGRQKwpKcTNNbHMzaDVXTnJ5RTdhTTQ5S3JaRWpjbytzajVRc3dMMnkwTk1weHdHRE9palpqS0lyCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg==")
var rsPubKeyPEM = Base64Encoder.decode("LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUF4RXltamxtUE1Vc3ZFNVBVK0FUUwpOd2c0dkxtS2tEMzFTRzI4WkRuN0RoNmMxT0FoWVgveUVwKzVCWHE4eWJCa1JwZkMvN3NyUlE0K1R4bm5Hc3BQCnQvZVF5S2ZORjgwbHd5NFRSQS9TYlJDallmK05UcTZlOHYzUUg4TTlTY2lLTUcwT0xtdk1uT2dWL21UUlV3WlMKdUxPZXRaTEQxNmdDZ2QxR0cwc01BS0JYYkpaZzJvejF0SnVsUE90YUNZbVF4dTUzY1ZIa2ZEdkYvNEswbUsxMgoyam8xRnh4UGtBbjNOcU1Db2QzR3hpOFVIaE5iMHM4eGxXOXpieW9zZGZ0Ymo5YjVUZEJNcFJTOWZFaWVzWmxBClpxOGtPa1lUUnJVVHJZdjI1d2pYaEhCSGNOeUtUSENuNVhkaXZ1N3NkUExlUERqOG5IUm5MajRya1NqS3BpRkcKYXdJREFRQUIKLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg==");
var rsPubKeyModulus = "C44CA68E598F314B2F1393D4F804D2370838BCB98A903DF5486DBC6439FB0E1E9CD4E021617FF2129FB9057ABCC9B0644697C2FFBB2B450E3E4F19E71ACA4FB7F790C8A7CD17CD25C32E13440FD26D10A361FF8D4EAE9EF2FDD01FC33D49C88A306D0E2E6BCC9CE815FE64D1530652B8B39EB592C3D7A80281DD461B4B0C00A0576C9660DA8CF5B49BA53CEB5A098990C6EE777151E47C3BC5FF82B498AD76DA3A35171C4F9009F736A302A1DDC6C62F141E135BD2CF31956F736F2A2C75FB5B8FD6F94DD04CA514BD7C489EB1994066AF243A461346B513AD8BF6E708D784704770DC8A4C70A7E57762BEEEEC74F2DE3C38FC9C74672E3E2B9128CAA621466B";
var rsPubKeyExponent = "10001";


var es256 = "{\"alg\":\"ES256\"}";
var es384 = "{\"alg\":\"ES384\"}";
var es512 = "{\"alg\":\"ES512\"}";

var rs256 = "{\"alg\":\"RS256\"}";
var rs384 = "{\"alg\":\"RS384\"}";
var rs512 = "{\"alg\":\"RS512\"}";

var hmacKey = "hmackey"
var sampleHS256 = "eyJ0eXAiOiJKV1QiLA0KICJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ.AF9JZKWRn2omJDrJrWeoVQyjR3PcGFiAe0_dC04hwyE";
var sampleRS256 = "eyJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ.PD3-BJR3UrF6del98ffZ8d8Vu3RMLhqj117r6LQNpM5eMImCKarEpqf6j1cu2FZZ9zQzusXPkBYPTUE1SKg8lzJmHbgSAaSunxxprS_XNYbFg8y9twxYBHh3umyJ0JTBWx5OciLQuapX8fKCZXINUXl1ytR1CCw4tSwD3ekMddLlAkmqdn7gYpIswaAO7bMOqrszXM5QAh7AMCwoisFBvUDFCrzs0alLIcPButn6vXo0p7vhakXXUPy7vRgTMsf3kSJcvJzLtxlcV0K1LiiR3wR_dcxSeRNkm075uIggTmSXhtUm7cswEr1u5YVN7F2v1pjg_KYwnhtRkP8AGU-k9g";


function assert(x) 
{
  if (!x) throw "AssertionFailure";
}

%>
</head>

<body class="autodoctest">
<!-- the autotest class tells doctest to run the tests and fill
in extra elements automatically -->

<h1>JSON Web Token tests</h1>
<div class="test"> </div>
<h2>Test Encodings</h2>
<div class="test"> A simple JSON object is correctly converted to Base64url.
  <pre class="doctest">
$ jwt.base64urlencode(joeStr); // note absence of padding == at end of string
"eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ"
Server Response:<%=jwt.base64urlencode(joeStr)%>
</pre>
  <!-- // to test: does this properly handle high-byte characters? --> 
</div>
<div class="test"> An HS256 algorithm element is correctly converted to Base64url.
  <pre class="doctest">
$ jwt.base64urlencode(hs256);
"eyJ0eXAiOiJKV1QiLA0KICJhbGciOiJIUzI1NiJ9"
Server Response:"<%=jwt.base64urlencode(hs256)%>"
</pre>
</div>
<div class="test"> An ES256 algorithm element is correctly converted to Base64url.
  <pre class="doctest">
$ jwt.base64urlencode(es256);
"eyJhbGciOiJFUzI1NiJ9"
Server Response:"<%=jwt.base64urlencode(es256)%>"
</pre>
</div>
<div class="test"> An RS256 algorithm element is correctly converted to Base64url.
  <pre class="doctest">
$ jwt.base64urlencode(rs256);
"eyJhbGciOiJSUzI1NiJ9"
Server Response:"<%=jwt.base64urlencode(rs256)%>"
</pre>
</div>
<h2>Test Digest Functions</h2>
<div class="test"> SHA256 implementation appears to be correct:
  <pre class="doctest">
$ sjcl.codec.hex.fromBits(sjcl.hash.sha256.hash("Hello World"));
"a591a6d40bf420404a011733cfb7b190d62c65bf0bcda32b57b277d9ad9f146e"
Server Response:"<%=sjcl.codec.hex.fromBits(sjcl.hash.sha256.hash("Hello World"))%>"

$ sjcl.codec.hex.fromBits(sjcl.hash.sha256.hash("ABCDEFGHIJKLMNOPQRSTUVWXYZ"));
"d6ec6898de87ddac6e5b3611708a7aa1c2d298293349cc1a6c299a1db7149d38"
Server Response:"<%=sjcl.codec.hex.fromBits(sjcl.hash.sha256.hash("ABCDEFGHIJKLMNOPQRSTUVWXYZ"))%>"

$ sjcl.codec.hex.fromBits(sjcl.hash.sha256.hash("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz01234567890./="));
"f250c33ac399835034a17e00afcc2fae03fd90389eef40f11e5123f154e1f9ca"
Server Response:"<%=sjcl.codec.hex.fromBits(sjcl.hash.sha256.hash("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz01234567890./="))%>"

</pre>
</div>
<h2>Test Signature Generation</h2>
<div class="test"> Test creation of an HMAC-SHA256 signature.
  <pre class="doctest">
<%
var token = new jwt.WebToken(joeStr, hs256);
var signed = token.serialize(hmacKey)
var split = signed.split("\.")
split.length
%>
$ var token = new jwt.WebToken(joeStr, hs256);
$ var signed = token.serialize(hmacKey)
$ var split = signed.split("\.")
$ split.length
3
Server Response:<%=split.length%>

$ split[0]
"eyJ0eXAiOiJKV1QiLA0KICJhbGciOiJIUzI1NiJ9"
Server Response:"<%=split[0]%>"

$ split[1]
"eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ"
Server Response:"<%=split[1]%>"

$ split[2] // correct value generated by OpenSSL; see make_samples.sh
"AF9JZKWRn2omJDrJrWeoVQyjR3PcGFiAe0_dC04hwyE"
Server Response:"<%=split[2]%>"
</pre>
</div>
<div class="test"> Test creation of an RSA-SHA256 signature.
  <pre class="doctest">
<%
var token = new jwt.WebToken(joeStr, rs256);
var signed = token.serialize(rsKeyPEM)
var split = signed.split("\.")
%>
$ var token = new jwt.WebToken(joeStr, rs256);
$ var signed = token.serialize(rsKeyPEM)
$ var split = signed.split("\.")
$ split.length
3
Server Response:<%=split.length%>
$ split[0]
"eyJhbGciOiJSUzI1NiJ9"
Server Response:"<%=split[0]%>"

$ split[1]
"eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ"
Server Response:"<%=split[1]%>"

$ split[2] // correct value generated by OpenSSL; see make_samples.sh
"PD3-BJR3UrF6del98ffZ8d8Vu3RMLhqj117r6LQNpM5eMImCKarEpqf6j1cu2FZZ9zQzusXPkBYPTUE1SKg8lzJmHbgSAaSunxxprS_XNYbFg8y9twxYBHh3umyJ0JTBWx5OciLQuapX8fKCZXINUXl1ytR1CCw4tSwD3ekMddLlAkmqdn7gYpIswaAO7bMOqrszXM5QAh7AMCwoisFBvUDFCrzs0alLIcPButn6vXo0p7vhakXXUPy7vRgTMsf3kSJcvJzLtxlcV0K1LiiR3wR_dcxSeRNkm075uIggTmSXhtUm7cswEr1u5YVN7F2v1pjg_KYwnhtRkP8AGU-k9g"
Server Response:"<%=split[2]%>"

</pre>
</div>
<div class="test"> RSA-SHA384 is unsupported.
  <pre class="doctest">
$ var token = new jwt.WebToken(joeStr, rs384);
$ token.serialize(rsKeyPEM);
Error: RSA-SHA384 not yet implemented
<%
try{
	var token = new jwt.WebToken(joeStr, rs384);
	token.serialize(rsKeyPEM);
}
catch(e){
	Response.Write("Server Response:" + e.message)
}
%>
</pre>
</div>
<div class="test"> RSA-SHA512 is unsupported.
  <pre class="doctest">
$ var token = new jwt.WebToken(joeStr, rs512);
$ token.serialize(rsKeyPEM);
Error: RSA-SHA512 not yet implemented
<%
try{
	var token = new jwt.WebToken(joeStr, rs512);
	token.serialize(rsKeyPEM);
}
catch(e){
	Response.Write("Server Response:" + e.message)
}
%>
</pre>
</div>
<div class="test"> HMAC-SHA384 is unsupported.
  <pre class="doctest">
$ var token = new jwt.WebToken(joeStr, hs384);
$ token.serialize(hmacKey);
Error: HMAC-SHA384 not yet implemented
<%
try{
	var token = new jwt.WebToken(joeStr, hs384);
	token.serialize(rsKeyPEM);
}
catch(e){
	Response.Write("Server Response:" + e.message)
}
%>
</pre>
</div>
<div class="test"> HMAC-SHA512 is unsupported.
  <pre class="doctest">
$ var token = new jwt.WebToken(joeStr, hs512);
$ token.serialize(hmacKey);
Error: HMAC-SHA512 not yet implemented
<%
try{
	var token = new jwt.WebToken(joeStr, hs512);
	token.serialize(hmacKey);
}
catch(e){
	Response.Write("Server Response:" + e.message)
}
%>
</pre>
</div>
<div class="test"> ECDSA-SHA384 is unsupported.
  <pre class="doctest">
$ var token = new jwt.WebToken(joeStr, es384);
$ token.serialize(hmacKey);
Error: ECDSA-SHA384 not yet implemented
<%
try{
	var token = new jwt.WebToken(joeStr, es384);
	token.serialize(hmacKey);
}
catch(e){
	Response.Write("Server Response:" + e.message)
}
%>
</pre>
</div>
<div class="test"> ECDSA-SHA512 is unsupported.
  <pre class="doctest">
$ var token = new jwt.WebToken(joeStr, es512);
$ token.serialize(hmacKey);
Error: ECDSA-SHA512 not yet implemented
<%
try{
	var token = new jwt.WebToken(joeStr, es512);
	token.serialize(hmacKey);
}
catch(e){
	Response.Write("Server Response:" + e.message)
}
%>

</pre>
</div>
<h2>Test Signature Verification</h2>
<div class="test"> Test verification of an HMAC-SHA256 signature.
  <pre class="doctest">
$ var token = jwt.WebTokenParser.parse(sampleHS256);
$ token.verify(hmacKey)
true
<%
var token = jwt.WebTokenParser.parse(sampleHS256);
Response.Write("Server Response:" + token.verify(hmacKey))
%>

</pre>
</div>
<div class="test"> Test verification of an RSA-SHA256 signature.
  <pre class="doctest">
$ var token = jwt.WebTokenParser.parse(sampleRS256);
$ var pubKey = new RSAKey();
$ pubKey.setPublic(rsPubKeyModulus, rsPubKeyExponent);
$ token.verify(pubKey)
true
<%
var token = jwt.WebTokenParser.parse(sampleRS256);
var pubKey = new RSAKey();
pubKey.setPublic(rsPubKeyModulus, rsPubKeyExponent);
Response.Write("Server Response:" + token.verify(pubKey))
%>
</pre>
</div><!--
<div class="test"> Test verification of an EDSA Signature according to Draft 01.
  <pre class="doctest">
$ var ec256Token = "eyJhbGciOiJFUzI1NiJ9.eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ.DtEhU3ljbEg8L38VWAfUAqOyKAM6-Xx-F4GawxaepmXFCgfTjDxw5djxLa8ISlSApmWQxfKTUJqPP3-Kg6NU1Q";
$ var x = [127, 205, 206, 39, 112, 246, 196, 93, 65, 131, 203, 238, 111, 219, 75, 123, 88, 7, 51, 53, 123, 233, 239, 19, 186, 207, 110, 60, 123, 209, 84, 69];
$ var y = [199, 241, 68, 205, 27, 189, 155, 126, 135, 44, 223, 237, 185, 238, 185, 244, 179, 105, 93, 110, 169, 11, 36, 173, 138, 70, 35, 40, 133, 136, 229, 173];
$ var token = jwt.WebTokenParser.parse(ec256Token);
$ token.verify(x, y);
true
<%/*
var ec256Token = "eyJhbGciOiJFUzI1NiJ9.eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ.DtEhU3ljbEg8L38VWAfUAqOyKAM6-Xx-F4GawxaepmXFCgfTjDxw5djxLa8ISlSApmWQxfKTUJqPP3-Kg6NU1Q";
var x = [127, 205, 206, 39, 112, 246, 196, 93, 65, 131, 203, 238, 111, 219, 75, 123, 88, 7, 51, 53, 123, 233, 239, 19, 186, 207, 110, 60, 123, 209, 84, 69];
var y = [199, 241, 68, 205, 27, 189, 155, 126, 135, 44, 223, 237, 185, 238, 185, 244, 179, 105, 93, 110, 169, 11, 36, 173, 138, 70, 35, 40, 133, 136, 229, 173];
var token = jwt.WebTokenParser.parse(ec256Token);
Response.Write("Server Response:" + token.verify(x, y))*/
%>
</pre>
</div>
-->
<!--     Error: ECDSA-SHA256 not yet implemented! -->

</body>
</html>
