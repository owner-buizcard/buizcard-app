
class UrlsConst {

  UrlsConst._();

  static String apiHost = "https://buizcard.co";
  static String domain = "https://buizcard.com/";

  static String googleAuth = "$apiHost/auth/google";
  static String githubAuth = "$apiHost/auth/github";
  static String linkedinAuth = "https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=7782mi1w2h629z&redirect_uri=$apiHost/auth/callback/linkedin&state=foobar&scope=profile%20openid%20email";
}