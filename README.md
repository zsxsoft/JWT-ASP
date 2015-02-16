JWT-ASP - JSON Web Tokens implemented in ASP JScript
=======

 该项目的大部分文件来源于：[https://github.com/michaelrhanson/jwt-js](https://github.com/michaelrhanson/jwt-js)，作者 Michael Hanson mhanson@mozilla.com。我本人只是将其改写为了ASP JScript版本，仅此而已。 

 除非另有说明，否则本项目所有文件采用MPL1.1/GPL2.0/LGPL2.1授权协议。虽然你拿走了我也不知道~ 

 该项目是JSON Web Tokens在ASP JScript的实现。规范参考网址是http://self-issued.info/docs/draft-jones-json-web-token-01.html。 

 建议在IIS6（Windows Server 2003）和以上版本的IIS运行。 

 如何使用？ 

> 1.  拷贝全部文件到网站文件夹（如：D:\Web\asp-js\）
> 2.  在浏览器内直接打开tests/文件夹（如：http://localhost/asp-js/test/）
> 3.  然后没什么了

 如何在ASP JScript下使用？

> 1.  拷贝全部文件到网站文件夹（如：D:\Web\asp-js\）
> 2.  直接&lt;!-- #include file=&quot;jwt.asp&quot;--&gt;即可。

 如何在ASP VBScript下调用？ 

> 1.  拷贝全部文件到网站文件夹（如：D:\Web\asp-js\）
> 2.  把所有文件的&lt;%换成&lt;script language=&quot;javascript&quot; runat=&quot;server&quot;&gt;，%&gt;换成&lt;/script&gt;
> 3.  &lt;!-- #include file=&quot;jwt.asp&quot;--&gt;
> 
> 4.  使用VBScript调用JScript函数的方法调用。

加密中文时必须使用JSONEncode函数对中文进行转码，否则结果可能有问题！

实例：

> ```javascript
> 
> function getjwt(){
> 	var token = new jwt.WebToken('{"short_name": "short_name","user_key": "1", "name": "你好世界"}', '{"typ":"JWT","alg":"HS256"}');
> 	var signed = token.serialize("密钥");
> 	return signed;
> }

 注意：测试样例中的RSA-SHA256算法会会满载CPU，一般情况下请勿使用！ 

 本人博客地址：[http://www.zsxsoft.com](http://www.zsxsoft.com) 

 ***** BEGIN LICENSE BLOCK ***** 

 * Version: MPL 1.1/GPL 2.0/LGPL 2.1 

 * 

 * The contents of this file are subject to the Mozilla Public License Version 

 * 1.1 (the &quot;License&quot;); you may not use this file except in compliance with 

 * the License. You may obtain a copy of the License at 

 * http://www.mozilla.org/MPL/ 

 * 

 * Software distributed under the License is distributed on an &quot;AS IS&quot; basis, 

 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License 

 * for the specific language governing rights and limitations under the 

 * License. 

 * 

 * Contributor(s): 

 *   zsx &lt;zsx@zsxsoft.com&gt; 

 * 

 * Alternatively, the contents of this file may be used under the terms of 

 * either the GNU General Public License Version 2 or later (the &quot;GPL&quot;), or 

 * the GNU Lesser General Public License Version 2.1 or later (the &quot;LGPL&quot;), 

 * in which case the provisions of the GPL or the LGPL are applicable instead 

 * of those above. If you wish to allow use of your version of this file only 

 * under the terms of either the GPL or the LGPL, and not to allow others to 

 * use your version of this file under the terms of the MPL, indicate your 

 * decision by deleting the provisions above and replace them with the notice 

 * and other provisions required by the GPL or the LGPL. If you do not delete 

 * the provisions above, a recipient may use your version of this file under 

 * the terms of any one of the MPL, the GPL or the LGPL. 

 * 

 * ***** END LICENSE BLOCK ***** */ 

 
