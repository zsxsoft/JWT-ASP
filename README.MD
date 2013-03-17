asp-jwt - JSON Web Tokens implemented in ASP JScript

该项目的大部分文件来源于：https://github.com/michaelrhanson/jwt-js，作者Michael Hanson <mhanson@mozilla.com>。我本人只是将其改写为了ASP JScript版本，仅此而已。

除非另有说明，否则本项目所有文件采用MPL1.1/GPL2.0/LGPL2.1授权协议。虽然你拿走了我也不知道~

该项目是JSON Web Tokens在ASP JScript的实现。规范参考网址是http://self-issued.info/docs/draft-jones-json-web-token-01.html。

建议在IIS6（Windows Server 2003）和以上版本的IIS运行。

如何使用？
   1.拷贝全部文件到网站文件夹（如：D:\Web\asp-js\）
   2.在浏览器内直接打开tests/文件夹（如：http://localhost/asp-js/test/）
   3.然后没什么了
   
注意：测试样例中的RSA-SHA256算法会会满载CPU，一般情况下请勿使用！


我的博客地址：http://www.zsxsoft.com。




***** BEGIN LICENSE BLOCK *****
* Version: MPL 1.1/GPL 2.0/LGPL 2.1
*
* The contents of this file are subject to the Mozilla Public License Version
* 1.1 (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
* http://www.mozilla.org/MPL/
*
* Software distributed under the License is distributed on an "AS IS" basis,
* WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
* for the specific language governing rights and limitations under the
* License.
*
* Contributor(s):
*   zsx <zsx@zsxsoft.com>
*
* Alternatively, the contents of this file may be used under the terms of
* either the GNU General Public License Version 2 or later (the "GPL"), or
* the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
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
