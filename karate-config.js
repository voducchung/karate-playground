function fn() {
  let config = {
    baseUrl: '',
  };

  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);

  return config;
}
