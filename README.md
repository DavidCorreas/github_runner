# Usar github_runner para un repositorio

Para usar el repositorio se tienen que usar los siguientes ficheros:

- Dockerfile
- docker-compose.yml
- .env
- runner.bash

## Acciones

1. Hay que cambiar el `.env`

```bash
GH_OWNER=<Nombre del usuario>ButlerHat
GH_REPOSITORY=<nombre del repo.>CicloZero
GH_TOKEN=<api token(fine grained)>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
RUNNER_NAME=<nombre del runner>omen-ubuntu
WORK_DIRECTORY=<workdir>/home/vscode/work
LABELS=<para usar en action>ubuntu,self-hosted,omen-ubuntu
```

Y cambiarle el `container_name` en el `docker-compose.yml`
