# Shell Scripts

Aqui há uma coleção de scripts de shell para diversas tarefas. Estes scripts são projetados para facilitar a automação de tarefas comuns no ambiente de linha de comando. Eu escrevi alguns apenas para testar coisas como o [hello world](./hello-world.sh) e [dotenv print](./dotenv-print.sh), enquanto outros são efetivamente parte do meu dia a dia como o [ts create](./ts-create.sh) que utiliza um template meu para inicializar um projeto TypeScript.

## Descrição breve dos scripts

| Script | Descrição |
|--------|-----------|
| [hello-world.sh](./hello-world.sh) | Exemplo de uso de `getopts` para parsing de flags (`-n` para nome, `-v` para modo verboso). |
| [dotenv-print.sh](./dotenv-print.sh) | Carrega e imprime as variáveis de ambiente de um arquivo `.env` usando `dotenv` e Node.js. |
| [ts-create.sh](./ts-create.sh) | Cria um novo projeto TypeScript a partir de um template local e inicializa um repositório Git. |
| [ts-invoke.sh](./ts-invoke.sh) | Executa um arquivo JS compilado (`./build/event.js`) com variáveis de ambiente carregadas de um `.env`. |
| [sls-create.sh](./sls-create.sh) | Cria um novo projeto Serverless com TypeScript a partir de um template local e inicializa o repositório. |
| [sls-invoke.sh](./sls-invoke.sh) | Executa `./src/event.js` localmente com variáveis de ambiente carregadas de um `.env` via `dotenv`. |
| [fuzzy-search.sh](./fuzzy-search.sh) | Busca conteúdo dentro de diretórios cujo nome corresponde a um substring, ignorando pastas como `node_modules`, `.git`, etc. |
| [update-lambda-alias.sh](./update-lambda-alias.sh) | Atualiza o alias `prod` para apontar para `$LATEST` em todas as funções Lambda que correspondem a um prefixo. |
| [create-shortcut.sh](./create-shortcut.sh) | Gera um atalho `.desktop` para jogos/aplicações Wine a partir de um template, recebendo nome, executável e ícone. |
| [copy-path.sh](./copy-path.sh) | Copia o caminho absoluto de um arquivo ou diretório para a área de transferência usando `wl-copy`. |
