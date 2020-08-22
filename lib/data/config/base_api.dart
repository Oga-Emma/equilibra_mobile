import 'package:helper_widgets/string_utils/string_utils.dart';

class BaseApi {
  final BASE_URL = "https://api.equilibra-admin.test.natterbase.com/users-api";
  final PAYSTACK_PUBLIC_KEY =
      "sk_test_754deb45f56f56dee7ae3ebfed24ca4a8dbf3eb6";
//  final BASE_URL = "http://178.62.34.18/api/v1";

  getErrorMessage(err) {
    if (err != null && StringUtils.isNotEmpty(err.message)) {
      return err.message;
    }
    return "Unknown error";
  }

  handleError(Map<String, dynamic> error) {
    if (error['message'] != null) {
      return error['message'];
    }

    if (error['data']['message'] != null) {
      return error['data']['message'];
    }

    throw "$error";
  }
}
