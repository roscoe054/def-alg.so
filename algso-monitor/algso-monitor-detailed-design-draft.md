# alg.so 算法监控平台详细设计

## 1.要具备的功能

   暂时只考虑对可用性的监控，以及API是由第三方提供服务的情况。
   默认API是REST风格的API。

+  提供可动态增加、删除需要监控的API的HTTP接口；
+  定时向需要监控的API发送请求，对返回结果验证是否与预期值一致；
   预期值由API提交者提供, 对于符合预期值的API设置状态为可用，
   其他状态为不可用;
+  提供查询API可用性状态的HTTP接口；

## 2.接口的定义

### 2.1 增加API的HTTP接口
        
	URL: {version}/3rdapi/add
	Method: POST
 	Parameters:
<table>
    <tr><td>参数名</td><td>必选</td><td>类型及范围</td><td>备注</td></tr>
    <tr><td>id</td><td>true</td><td>uint64</td><td>该API地址ID</td></tr>
    <tr><td>url</td><td>true</td><td>string</td><td>API服务地址</td></tr>
</table>
