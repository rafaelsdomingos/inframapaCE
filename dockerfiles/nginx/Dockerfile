FROM nginx:latest

COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf
COPY init.sh /usr/share/nginx/init.sh

# Defina as permissões do script
RUN chmod +x /usr/share/nginx/init.sh

# Exponha a porta 80 (ou qualquer outra que você precise)
EXPOSE 80

# Execute o script de inicialização ao iniciar o contêiner
CMD ["/usr/share/nginx/init.sh"]