# Usar uma imagem base oficial do Python
FROM python:3.9-slim

# Definir o diretório de trabalho no contêiner
WORKDIR /app

# Copiar os arquivos do projeto para o diretório de trabalho
COPY . /app

# Instalar as dependências do projeto
RUN pip install --no-cache-dir -r requirements.txt

# Expor a porta 5000
EXPOSE 5000

# Comando para rodar a aplicação usando waitress
CMD ["waitress-serve", "--port=5000", "app:app"]
