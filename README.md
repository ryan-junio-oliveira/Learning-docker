# Manual de Comandos Docker

Este é um guia abrangente para os principais comandos do Docker. Aqui estão mais comandos para ajudar no gerenciamento de imagens, containers, redes e volumes Docker.

# Site para gerar projetos
https://phpdocker.io/

---

## Comandos Gerais

- `docker --version`: Exibe a versão instalada do Docker.
- `docker info`: Mostra informações sobre a instalação do Docker, incluindo número de containers, imagens, volumes e redes.
- `docker --help`: Lista todos os comandos disponíveis do Docker.
- `docker search <termo>`: Procura por imagens no Docker Hub.
- `docker system df`: Mostra o uso de espaço do Docker.
- `docker system prune`: Remove todos os containers parados, redes não utilizadas e imagens sem tags.
- `docker login`: Faz login no Docker Hub.
- `docker logout`: Faz logout do Docker Hub.

---

## Gerenciamento de Imagens

- `docker image ls`: Lista todas as imagens Docker locais.
- `docker pull <imagem>`: Faz o download de uma imagem do Docker Hub ou de um registro especificado.
- `docker build -t <nome_imagem> .`: Cria uma nova imagem a partir de um Dockerfile.
- `docker push <imagem>`: Envia uma imagem para o Docker Hub ou um registro especificado.
- `docker rmi <imagem>`: Remove uma ou mais imagens locais.
- `docker image prune`: Remove imagens não utilizadas.

---

## Gerenciamento de Containers

- `docker container ls`: Lista todos os containers em execução.
- `docker container ls -a`: Lista todos os containers, incluindo os parados.
- `docker run <imagem>`: Cria e inicia um novo container a partir de uma imagem.
- `docker start <container>`: Inicia um ou mais containers parados.
- `docker stop <container>`: Para um ou mais containers em execução.
- `docker rm <container>`: Remove um ou mais containers.
- `docker logs <container>`: Exibe os logs de um container.
- `docker exec -it <container> <comando>`: Executa um comando em um container em execução.
- `docker stats <container>`: Exibe estatísticas de uso de recursos de um container.

---

## Gerenciamento de Redes

- `docker network ls`: Lista todas as redes Docker.
- `docker network inspect <rede>`: Exibe informações detalhadas sobre uma rede.
- `docker network create <rede>`: Cria uma nova rede.
- `docker network connect <rede> <container>`: Conecta um container a uma rede.
- `docker network disconnect <rede> <container>`: Desconecta um container de uma rede.
- `docker network prune`: Remove redes não utilizadas.

---

## Gerenciamento de Volumes

- `docker volume ls`: Lista todos os volumes Docker.
- `docker volume create <volume>`: Cria um novo volume.
- `docker volume inspect <volume>`: Exibe informações detalhadas sobre um volume.
- `docker volume rm <volume>`: Remove um ou mais volumes.
- `docker volume prune`: Remove volumes não utilizados.

---

## Gerenciando Containers

### Iniciando

```bash
docker container run -p 8080:80 nginx
```

Caso não tenhamos a imagem localmente em nossa máquina, o próprio Docker se encarregará de baixá-la. Abra um novo terminal e digite:

```bash
docker container ls
```

Acesse o endereço `http://127.0.0.1:8080` para visualizar a página de boas-vindas do nginx.

### Parando o Container

```bash
docker container ls
```

Exemplo de container listado:
```
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                  NAMES
5198670617c7   nginx     "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   0.0.0.0:8080->80/tcp   awesome_mestorf
```

Para parar:
```bash
docker container stop 5198670617c7
```

### Removendo Container

```bash
docker container rm 5198670617c7
# ou
docker container rm -f 5198670617c7
```

Remover todos:
```bash
docker container rm $(docker container ls -a -q)
```

### Nomeando Containers

```bash
docker container run -d -p 8080:80 --name appNginx nginx
```

### Verificando Logs

```bash
docker container logs appNginx
# em tempo real:
docker container logs -f appNginx
```

### Processos de um Container

```bash
docker container top appNginx
```

### Utilização de Recursos

```bash
docker container stats
# ou
docker container stats appNginx
```

### Verificar Informações do Container

```bash
docker container inspect appNginx
```

---

## Comandos Docker Compose Essenciais

### Subir Serviços
```bash
docker-compose up
# em segundo plano e forçando build:
docker-compose up -d --build
```

### Parar e Limpar
```bash
docker-compose down -v --remove-orphans && docker volume prune -f
```

### Build de Serviços
```bash
docker-compose build
# serviço específico
docker-compose build nome-do-servico
```

### Logs
```bash
docker-compose logs
# logs em tempo real de um serviço específico
docker-compose logs -f app
```

### Executar Comando em Serviço
```bash
docker-compose exec app bash
```

### Start, Stop e Restart
```bash
docker-compose start

docker-compose stop

docker-compose restart
```

### Verificar Containers
```bash
docker-compose ps
```

---

## Docker Compose vs Docker Puro

| Ação | Docker Compose | Docker Puro |
|------|----------------|-------------|
| Subir | `docker-compose up -d` | `docker run -d -p 8080:80 nginx` |
| Parar e remover tudo | `docker-compose down -v --remove-orphans && docker volume prune -f` | `docker stop $(docker ps -aq) && docker rm -f $(docker ps -aq) && docker volume prune -f` |
| Executar comando | `docker-compose exec app bash` | `docker exec -it container bash` |
| Logs | `docker-compose logs -f` | `docker logs -f container` |

---

Para aprofundar seu conhecimento, acesse a [documentação oficial do Docker](https://docs.docker.com/).
