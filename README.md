
# Reddit Client - [DEMO]

## Tempo gasto no desenvolvimento: 12 horas

Um client do reddit simplificado - é possível buscar por subreddit, navegar entre as sugestões pré-definidas e visualizar os comentários de cada postagem (se houver).


## Funcionalidades

- Pesquisar por subreddit's;
- Navegar entre as sugestões de comunidades pré-definidas e histórico de comunidades pesquisadas;
- Paginação de conteúdo;
- Visualizar comentários do post.

- O App realiza duas chamadas à API, são elas:
  1- Pesquisar os top post's de um subreddit, listando os 100 primeiros resultados;
  2- Pesquisar os comentários de uma postagem;

## Instalação

O projeto pode ser executado em modo debug a partir da IDE (recomendo o VS Code - por já ter os arquivos de execução configurados). Caso prefira executar-lo a partir de um terminal, com o aparelho conectado no computador, digite:

```bash
  flutter pub get
  flutter run -d <id_dispositivo>
```

Caso prefira instalar o .apk diretamente, o arquivo se encontra em: `/assets/reddit_client.apk `

    