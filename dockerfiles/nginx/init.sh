#!/bin/bash

# Verifique se a pasta de interesse existe
if [ -d "/var/www" ]; then
    # Modifique as permissões da pasta conforme necessário
    chown -R www-data:www-data /var/www/
else
    echo "A pasta não existe. Certifique-se de que o caminho esteja correto."
fi

# Inicie o Nginx
exec nginx -g 'daemon off;'