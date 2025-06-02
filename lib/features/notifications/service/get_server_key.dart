import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    List<String> scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(
        {
          "type": "service_account",
          "project_id": "sis-tm",
          "private_key_id": "a90ce3f5e9fb567e7b8c74b2541f4516dcc1226e",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC47Ssi33kiFmka\ns+RqdJziN+w7ri/8CoSOF0nRz0vSuUpljqai6rzUHNw6BSSG9eQ+lYifSY6xz20q\nuMztRZEmMqNKLCCsSI0ciG/k2XC+dEsoZyIpjYh/IVLl9plVHC8+x3xTY5B3zkt9\nnw9BNqapJzEnzbYy9TYPKxMrbKABZweARALnZlSxpppGV5P7bGhxujsFuQiE+Jy/\nUaq/DkBbaMyUy/uxubJEJWvTvgeVnp26xG+yil1GzUWg2LNu3DauJiBO4QyO1H7J\nAH6zUNkx/MFsgczXKjirvX1m3I0DmMNMNxv7RPoba4w186VtnMyx/jE6hZKO7dps\nncnUmFbpAgMBAAECggEAAebehLNLqaAVYKLs/HNKkcEFeu+lqq/pARUYO0Iog3hI\nXZcD+7TyUDQjx6z53TF2MXaUOx8kiouZkdDoup/2iDAJIeAmTd9JJDv6+p2J3UuQ\n4k99OHQuLTCIi7jnhsqNadXfX3Qsri6+9AHIxGDtgdvXU5N4BjojXjCRN+ccFieW\nmbPb39DHE6J1rwBlU66aCoieDrWzHkAHDn2FRcPmLOU4MJcx4TsDh9JFpwjktIf6\n5JpBDTemTM0i79xK/Oyf3Z8tSmgBfTNLyPCoqQjh8Tc3ZUA5nSza29/ElSGy+g0F\n/SNTp2trAu8GF+IGUCk+RQ8ACQ2FHWLBB1rbPTnIAQKBgQDyieFd4jSMeJb9cqP/\n1/zb27ZvP486qqy2u1kxu08KILTIzlPZRJV3AO+wLT1gyNpkceLz/dbbTwCEzyHm\nvLKi5kh10Xvscx58ZVy72xN/mhcryz66D+wAUa6b9l0LwkiKW+TRXbteCRHd674B\n+GLdJ8cDtZ7RGARPr0W6r2K8aQKBgQDDMLQWVLWfC6iPW6XHw79quvy8E709ihlE\nA8BZYX9snzS99c0JMk89++DaTKhAd20VXDIjBzxtSUu2kK1ckOKhXFwuEQh9Fhhj\niLGWJGCuotn1KubT9KTCVICnXWZlPkZU+/nfONt8yu4uU0fLpgMT418F/195tsWu\nZsnHtSd2gQKBgBxYJsFdDT0ZXrPx8N6WdFORYsmviOKXTaXxUSQxurP5TIdnLX9n\nt3v33QsezlyAPJ2efaJ8GN76ZZofxtt7U/kbpn42ZCAm9/obsnG10ZqI/Io+r275\nK2CCK0DI0ujr5KRexuf850e/EZp40XTTfWJRIr35PL087EwPtLtzgbt5AoGBAKaL\ndO2k479MJEwF5+MWa8p2t9UGhq7umXZGOSZKoX4eLdNz2rnhGmoJ86ZwSBORkxrp\nqsHml7GsG5Uvxyw3V5hVBTYtRG/unWq4JMa2TWRVAeJF8+SgVsCVd5zWfdsfEsXK\npj7H9cd6I1aVqqniAbhDhj3I0z84K14OyFbFhGGBAoGBAKRJZ1dhIwgor8WeE0y7\ndLSwjZzYsO3+vqJybUNdgdx8UI5nYDNVfjnlIo0NDy2jGxy4QTL4MVgf/iG14Hms\n5ANFX7k3ZQn1TKMl/ZUICLbVHyWNhjShpHCAKO/ZKmOh1h1cT+JKdVa+PDmX+0IR\na0EwM9Nzw4xbnbqFkf2Wywj5\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-i7s5n@sis-tm.iam.gserviceaccount.com",
          "client_id": "117999434067127921535",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-i7s5n%40sis-tm.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        },
      ),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
