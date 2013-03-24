JWT-ASP - JSON Web Tokens implemented in ASP JScript
=======
<p> 该项目的大部分文件来源于：<a href="https://github.com/michaelrhanson/jwt-js">https://github.com/michaelrhanson/jwt-js</a>，作者 Michael Hanson mhanson@mozilla.com。我本人只是将其改写为了ASP JScript版本，仅此而已。 </p>
<p> 除非另有说明，否则本项目所有文件采用MPL1.1/GPL2.0/LGPL2.1授权协议。虽然你拿走了我也不知道~ </p>
<p> 该项目是JSON Web Tokens在ASP JScript的实现。规范参考网址是http://self-issued.info/docs/draft-jones-json-web-token-01.html。 </p>
<p> 建议在IIS6（Windows Server 2003）和以上版本的IIS运行。 </p>
<p> <br />
</p>
<p> 如何使用？ </p>
<blockquote>
  <ol style="list-style-type:decimal;">
    <li>
      <p> 拷贝全部文件到网站文件夹（如：D:\Web\asp-js\） </p>
    </li>
    <li>
      <p> 在浏览器内直接打开tests/文件夹（如：http://localhost/asp-js/test/） </p>
    </li>
    <li>
      <p> 然后没什么了 </p>
    </li>
  </ol>
</blockquote>
<p> 如何在ASP JScript下使用？<br />
</p>
<blockquote>
  <ol style="list-style-type:decimal;">
    <li>
      <p> 拷贝全部文件到网站文件夹（如：D:\Web\asp-js\） </p>
    </li>
    <li>
      <p> 直接&lt;!-- #include file=&quot;jwt.asp&quot;--&gt;即可。 </p>
    </li>
  </ol>
</blockquote>
<p> 如何在ASP VBScript下调用？ </p>
<blockquote>
  <ol style="list-style-type:decimal;">
    <li>
      <p> 拷贝全部文件到网站文件夹（如：D:\Web\asp-js\） </p>
    </li>
    <li>
      <p> 把所有文件的&lt;%换成&lt;script language=&quot;javascript&quot; runat=&quot;server&quot;&gt;，%&gt;换成&lt;/script&gt; </p>
    </li>
    <li>
      <p> &lt;!-- #include file=&quot;jwt.asp&quot;--&gt;</p>
    </li>
    <li>
      <p> 使用VBScript调用JScript函数的方法调用。 </p></li>
  </ol>
  
</blockquote>
<p>加密中文时必须使用JSONEncode函数对中文进行转码，否则结果可能有问题！</p>
<p>实例：</p>

<blockquote>
```javascript
function getjwt(){
	var token = new jwt.WebToken('{"short_name": "short_name","user_key": "1", "name": "你好世界"}', '{"typ":"JWT","alg":"HS256"}');
	var signed = token.serialize("密钥");
	return signed;
}
</blockquote>
<p> 注意：测试样例中的RSA-SHA256算法会会满载CPU，一般情况下请勿使用！ </p>
<p></p>
<p> </p>
<p> 本人博客地址：<a href="http://www.zsxsoft.com" target="_blank">http://www.zsxsoft.com</a> </p>
<p><br/>
</p>
<p> ***** BEGIN LICENSE BLOCK ***** </p>
<p> * Version: MPL 1.1/GPL 2.0/LGPL 2.1 </p>
<p> * </p>
<p> * The contents of this file are subject to the Mozilla Public License Version </p>
<p> * 1.1 (the &quot;License&quot;); you may not use this file except in compliance with </p>
<p> * the License. You may obtain a copy of the License at </p>
<p> * http://www.mozilla.org/MPL/ </p>
<p> * </p>
<p> * Software distributed under the License is distributed on an &quot;AS IS&quot; basis, </p>
<p> * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License </p>
<p> * for the specific language governing rights and limitations under the </p>
<p> * License. </p>
<p> * </p>
<p> * Contributor(s): </p>
<p> *   zsx &lt;zsx@zsxsoft.com&gt; </p>
<p> * </p>
<p> * Alternatively, the contents of this file may be used under the terms of </p>
<p> * either the GNU General Public License Version 2 or later (the &quot;GPL&quot;), or </p>
<p> * the GNU Lesser General Public License Version 2.1 or later (the &quot;LGPL&quot;), </p>
<p> * in which case the provisions of the GPL or the LGPL are applicable instead </p>
<p> * of those above. If you wish to allow use of your version of this file only </p>
<p> * under the terms of either the GPL or the LGPL, and not to allow others to </p>
<p> * use your version of this file under the terms of the MPL, indicate your </p>
<p> * decision by deleting the provisions above and replace them with the notice </p>
<p> * and other provisions required by the GPL or the LGPL. If you do not delete </p>
<p> * the provisions above, a recipient may use your version of this file under </p>
<p> * the terms of any one of the MPL, the GPL or the LGPL. </p>
<p> * </p>
<p> * ***** END LICENSE BLOCK ***** */ </p>
<p> <br />
</p>
