
class UrlsConst {

  UrlsConst._();

  static String apiHost = "https://m93o2s6r6l.execute-api.us-east-1.amazonaws.com/dev";
  static String domain = "https://bizcard-spiderlingz.web.app/";

  static String googleAuth = "$apiHost/auth/google";
  static String githubAuth = "$apiHost/auth/github";
  static String linkedinAuth = "https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=864hy6jn3uyw75&redirect_uri=$apiHost/auth/callback/linkedin&state=foobar&scope=profile%20openid%20email";
}