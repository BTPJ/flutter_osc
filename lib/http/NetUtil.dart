import 'dart:async';
import 'package:http/http.dart' as http;

/// 网络请求工具类
class NetUtil {
  /// Http的Get请求，url:请求地址; params:请求参数
  static Future<String> get(String url, {Map<String, String> params}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer stringBuffer = new StringBuffer("?");
      params.forEach((key, value) {
        stringBuffer.write("$key = $value &");
      });

      String paramStr = stringBuffer.toString();
      url += paramStr.substring(0, paramStr.length - 1);
    }
    http.Response res = await http.get(url);
    print("url = $url");
    print("body = ${res.body}");
    return res.body;
  }

  /// Http的Post请求，url:请求地址; params:请求参数
  static Future<String> post(String url, {Map<String, String> params}) async {
    http.Response res = await http.post(url, body: params);
    return res.body;
  }
}
