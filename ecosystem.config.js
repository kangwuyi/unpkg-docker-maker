module.exports = {
  apps: [
    {
      name: 'unpkg',
      script: '/usr/src/app/unpkg/start.js',
      env: {
        NODE_ENV: 'production',
        NPM_REGISTRY_URL: 'https://registry.npmmirror.com',
        PORT: 8899,
      },
    },
  ],
}
