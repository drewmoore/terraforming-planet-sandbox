## Local Use

Uses [nvm](https://github.com/nvm-sh/nvm) for node version management.

```sh
cp .envrc.example .envrc.development
nvm use
npm ci
npm run start-local
```

Can request http://localhost:3000/hello?name=MyName
