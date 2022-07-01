# Terraforming Planet Sandbox
Demonstration on how to manage resources using terraform in a sandbox account

## Infrastructure

Apply the provided [infrastructure](./infrastructure) configuration using terraform.

## Local App

The web app can be [run locally](./app) and used for testing infrastructure in the sandbox, as well.

## Deploy

Will deploy the current local code to the lambda in the sandbox. This will have been created using the /infrastructure setup. Make sure your aws config is set to point to the sandbox.

```sh
./bin/deploy
```
