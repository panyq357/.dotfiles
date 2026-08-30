// Define main function (script entry)

function main(config) {
  if (Array.isArray(config.proxies)) {
    config.proxies.forEach((proxy) => {
      proxy.udp = true;
    });
  }
  return config;
}