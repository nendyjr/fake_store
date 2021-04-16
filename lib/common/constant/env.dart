class Env {
  Env(this.baseUrl);

  final String baseUrl;
}

mixin EnvValue {
  static final Env development = Env('https://fakestoreapi.com');
}
