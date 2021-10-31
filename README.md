# Docker

Este projeto está estruturado com os assuntos relacionados ao Docker.

**Aulas**

*[Aula 1 - Conceitos Básicos ](https://github.com/ifpb-disciplinas-2021-2/ads-dac-docker/commit/1a8e52b4bc75a35d38d874a869f381e597a4740a)*

<!-- *[Aula 2 - Dockerfile e Docker Compose ](https://github.com/ifpb-disciplinas-2021-2/ads-dac-docker/commit/38bc4de4545db6584bae1d95e4b609243c80c913)* -->


# Atividade prática

Realize o passo a passo descrito a seguir e verifique se os containeres estão sendo gerenciados conforme visto em aula.

Caso surja alguma dúvida no desenvolvimento, falar de imediato via [Slack](https://ifpb-20212-dac.slack.com/archives/C02K0QS2LQ3). 
> Lembrete: Não guardem dúvidas, elas são como as dívidas. Acumulam-se e nos prejudicam :)


## Criar o arquivo `Dockerfile` do banco PostgreSQL
```
FROM postgres
ENV POSTGRES_DB clientes
ENV POSTGRES_USER job
ENV POSTGRES_PASSWORD 123
COPY create.sql /docker-entrypoint-initdb.d/
COPY insert.sql /docker-entrypoint-initdb.d/
```
## Criar uma imagem do banco PostgreSQL
`docker image build -t ricardojob/banco ./postgres`:  
*`-t`: qual a tag que vamos atribuir a essa imagem*  
*`./postgres`: caminho relativo (ou absoluto) para o arquivo Dockerfile*  


## Criar o arquivo `Dockerfile` da aplicação
```
FROM tomcat
COPY /target/app.war ${CATALINA_HOME}/webapps
```

## Criar uma imagem da aplicação

`docker image build -t ricardojob/app:2 .`:  
*`-t`: qual a tag que vamos atribuir a essa imagem*  
*`.`: caminho relativo (ou absoluto) para o arquivo Dockerfile*  

## Executar o container  

`docker container run -p 5433:5432 -d --name banco ricardojob/banco` e 
`docker container run -p 8081:8080 -d --name app --link banco:host-banco ricardojob/app:2`:   
*`-p`: o bind entre a porta do host local com a porta do container*  
*`-d`: o container seja executar em background*  
*`--link`: o bind entre os containers, para pertimir que o container da aplicação tenha acesso ao container do banco*  
*`--name`: o nome do container*  


## Listar as imagens

`docker image ls`

## Listar os containers

`docker container ls`

## Parar o container

`docker container stop <container_id | container_name>`

## Executar comandos no container  

Para executarmos comandos necessitamos de executar o comando `docker exec -it <container_id | container_name> <command>`. 
Por exemplo, para termos acesso ao container do banco que configuramos podemos fazer:

`docker container exec -it banco /bin/bash`:  
*`-it`: para termos acesso iterativo ao TTY*  
*`banco`: o nome do container que desejamos seja executar determinado comando*  
*`/bin/bash`: o comando que vamos executar no container*  

Após esses passos, teremos acesso ao terminal do container. Podemos acessar o _database_ que definimos no arquivo `Dockerfile` que configura o banco de dados, neste exemplo `clientes`.

`psql -U postgres clientes`:  
*`-U`: usuário configurado*  
*`clientes`: o _database_ que desejamos acessar* 

Alguns comando úteis no `psql`:  
*`\dt`: lista as tabelas do _database_*    
*`select * from clientes;`: seleciona todos os clientes*  
*`INSERT INTO clientes(nome, cpf) VALUES ('Kiko','123.132.121-31');`: insere um novo cliente*    
*`\q`: sair do _database_*   