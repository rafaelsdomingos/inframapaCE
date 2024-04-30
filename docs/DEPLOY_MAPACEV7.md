# Deploy Mapa Cultural do Ceará V7

## Deploy via docker compose

```
version: '3.2'
services:
  nginx:
    image: secultceara/nginx:latest
    restart: unless-stopped
    volumes:
      - /dev/null:/var/www/html/index.php
      - public-files:/var/www/html/files
      - assets:/var/www/html/assets
    ports:
      - "80:80"
    depends_on:
      - mapasculturais
    links:
      - mapasculturais
  
  mapasculturais:
    image: secultceara/mapacultural:latest
    restart: unless-stopped
    environment:
      - BASE_URL=http://localhost/
      - APP_MODE=production
      - LOG_LEVEL=DEBUG
      - LOG_ENABLED=true
      - CEP_TOKEN=
      - MAILER_TRANSPORT=
      - MAILER_FROM=
        # Usado para redirecionar todos os e-mails da plataforma para um email fixo, 
        # evitand envio de emails para os usuários
      - MAILER_ALWAYSTO=
      - DB_HOST=db
      - DB_NAME=mapas
      - DB_USER=mapas
      - DB_PASS=mapas
      - DB_VERSION=14
      # as chaves abaixo são de desenvolvimento, precisam ser substituidas em ambiente de produção
      - GOOGLE_RECAPTCHA_SITEKEY=6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI
      - GOOGLE_RECAPTCHA_SECRET=6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe=
      - PENDING_PCACHE_RECREATION_INTERVAL=1
      - JOBS_INTERVAL=1
      - REDIS_CACHE=redis
      - SESSIONS_SAVE_PATH=tcp://sessions:6379
    volumes:
      - assets:/var/www/html/assets
      - public-files:/var/www/html/files
      - private-files:/var/www/var/private-files
      - saas-files:/var/www/var/saas-files
      - sessions:/var/www/var/sessions
      - logs:/var/www/var/logs
    links:
      - db
      - redis
      - sessions     

    depends_on:
      - db
      - redis
      - sessions

  redis:
    image: redis:6
    command: --maxmemory 1256Mb --maxmemory-policy allkeys-lru
    restart: unless-stopped
 
  sessions:
    image: redis:6
    command: --maxmemory 384Mb --maxmemory-policy allkeys-lru
    restart: unless-stopped
    volumes:
      - sessions:/data

  db:
    image: secultceara/postgres:14
    restart: unless-stopped
    environment:
      - POSTGRES_PASSWORD=mapas
      - POSTGRES_USER=mapas
      - POSTGRES_DB=mapas
    ports:
      - "5432:5432"
    volumes:
      - db-data:/var/lib/postgresql/data
    
# Configuração dos volumes
volumes:
  assets:
  db-data:
  logs:
  private-files:
  public-files:
  saas-files:
  sessions:


## Em ambiente de homologação pode ser uma boa ideia utilizar o mailhog para testar 
## o envio de emails e também prevenir que emails de tete sejam disparados acidentalmente 
## para os usuários no caso de o ambiente de homologação utilizar um banco de dados cópia
## de produção

  # mailhog: 
  #   image: mailhog/mailhog
  #   ports:
  #     - "8025:8025"
```

![Tela inicial Mapa Cultural do Ceará V5](../imagens/print_mapav7.png)