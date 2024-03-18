package model;

public class Constants {

    public static String GOOGLE_CLIENT_ID = "257156793950-querl7dnqmaq9cjfa1ou89sslsa6cof0.apps.googleusercontent.com";

    public static String GOOGLE_CLIENT_SECRET = "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";

    public static String GOOGLE_REDIRECT_URI = "http://localhost:8080/cuoiki_war_exploded/loginGoogle";

    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

    public static String GOOGLE_GRANT_TYPE = "authorization_code";

    public static String FACEBOOK_APP_ID = "390038746860422";
    public static String FACEBOOK_APP_SECRET = "30903101b413d4db368181c3630443fc";
    public static String FACEBOOK_REDIRECT_URL = "http://localhost:8080/cuoiki_war_exploded/login_facebook";
    public static String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/oauth/access_token?client_id=%s&client_secret=%s&redirect_uri=%s&code=%s";

}