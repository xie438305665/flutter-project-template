/// @description: 请求地址
/// @author xcl qq:244672784
/// @Date 2020/5/5 15:23
class NetUrl {
  //testing 环境
  static const BASE_TESTING_URL =
      "http//zsyapi.testing.xueping.com/coachio/iointerface_v2/";

  //dev环境
  static const BASE_DEV_URL =
      "http//zsyapi.dev.xueping.com/coachio/iointerface_v2/";

  //正式环境
  static const BASE_RELEASE_URL =
      "http//zsyapi.zhixinhuixue.com/coachio/iointerface_v2/";

  //登录
  static const LOGIN = "login";

  //获取产品信息
  static const GET_PRODUCT_DETAIL = "getProductDetail";

  //上传签名
  static const SAVE_SIGN_DATA = "saveSignData";
}
