# Manual de Comandos Docker

Este é um guia abrangente para os principais comandos do Docker. Aqui estão mais comandos para ajudar no gerenciamento de imagens, containers, redes e volumes Docker.

## Comandos Gerais

- `docker --version`: Exibe a versão instalada do Docker.
- `docker info`: Mostra informações sobre a instalação do Docker, incluindo número de containers, imagens, volumes e redes.
- `docker --help`: Lista todos os comandos disponíveis do Docker.
- `docker search <termo>`: Procura por imagens no Docker Hub.
- `docker system df`: Mostra o uso de espaço do Docker.
- `docker system prune`: Remove todos os containers parados, redes não utilizadas e imagens sem tags.
- `docker login`: Faz login no Docker Hub.
- `docker logout`: Faz logout do Docker Hub.

## Gerenciamento de Imagens

- `docker image ls`: Lista todas as imagens Docker locais.
- `docker pull <imagem>`: Faz o download de uma imagem do Docker Hub ou de um registro especificado.
- `docker build -t <nome_imagem> .`: Cria uma nova imagem a partir de um Dockerfile.
- `docker push <imagem>`: Envia uma imagem para o Docker Hub ou um registro especificado.
- `docker rmi <imagem>`: Remove uma ou mais imagens locais.
- `docker image prune`: Remove imagens não utilizadas.

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

## Gerenciamento de Redes

- `docker network ls`: Lista todas as redes Docker.
- `docker network inspect <rede>`: Exibe informações detalhadas sobre uma rede.
- `docker network create <rede>`: Cria uma nova rede.
- `docker network connect <rede> <container>`: Conecta um container a uma rede.
- `docker network disconnect <rede> <container>`: Desconecta um container de uma rede.
- `docker network prune`: Remove redes não utilizadas.

## Gerenciamento de Volumes

- `docker volume ls`: Lista todos os volumes Docker.
- `docker volume create <volume>`: Cria um novo volume.
- `docker volume inspect <volume>`: Exibe informações detalhadas sobre um volume.
- `docker volume rm <volume>`: Remove um ou mais volumes.
- `docker volume prune`: Remove volumes não utilizados.

Esses comandos abrangem uma variedade de funcionalidades do Docker para ajudar no gerenciamento eficiente de imagens, containers, redes e volumes. Explore mais opções e detalhes na documentação oficial do Docker, consulte o [site oficial do Docker](https://docs.docker.com/) para aprofundar seu conhecimento e aproveitar ao máximo essa poderosa ferramenta de virtualização de contêineres.
