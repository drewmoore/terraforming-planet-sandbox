# Infrastructure for the Sandbox

## Environment Variables

You will need to create the following file for environment variables and replace the example values with real ones.
```sh
cp .envrc.example .envrc
. .envrc
```

## How to Use

First install [tfenv](https://github.com/tfutils/tfenv). Then use that to install terraform.

```sh
tfenv use
terraform init
terraform apply
```
