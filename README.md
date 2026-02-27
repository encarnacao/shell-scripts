# Shell Scripts

Aqui há uma coleção de scripts de shell para diversas tarefas. Estes scripts são projetados para facilitar a automação de tarefas comuns no ambiente de linha de comando. Eu escrevi alguns apenas para testar coisas como o [hello world](./hello-world.sh) e [dotenv print](./dotenv-print.sh), enquanto outros são efetivamente parte do meu dia a dia como o [ts create](./ts-create.sh) que utiliza um template meu para inicializar um projeto TypeScript.

## Descrição breve dos scripts

| Script                                             | Descrição                                                                                                                    |
| -------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| [hello-world.sh](./hello-world.sh)                 | Exemplo de uso de `getopts` para parsing de flags (`-n` para nome, `-v` para modo verboso).                                  |
| [dotenv-print.sh](./dotenv-print.sh)               | Carrega e imprime as variáveis de ambiente de um arquivo `.env` usando `dotenv` e Node.js.                                   |
| [ts-create.sh](./ts-create.sh)                     | Cria um novo projeto TypeScript a partir de um template local e inicializa um repositório Git.                               |
| [ts-invoke.sh](./ts-invoke.sh)                     | Executa um arquivo JS compilado (`./build/event.js`) com variáveis de ambiente carregadas de um `.env`.                      |
| [sls-create.sh](./sls-create.sh)                   | Cria um novo projeto Serverless com TypeScript a partir de um template local e inicializa o repositório.                     |
| [sls-invoke.sh](./sls-invoke.sh)                   | Executa `./src/event.js` localmente com variáveis de ambiente carregadas de um `.env` via `dotenv`.                          |
| [fuzzy-search.sh](./fuzzy-search.sh)               | Busca conteúdo dentro de diretórios cujo nome corresponde a um substring, ignorando pastas como `node_modules`, `.git`, etc. |
| [update-lambda-alias.sh](./update-lambda-alias.sh) | Atualiza o alias `prod` para apontar para `$LATEST` em todas as funções Lambda que correspondem a um prefixo.                |
| [create-shortcut.sh](./create-shortcut.sh)         | Gera um atalho `.desktop` para jogos/aplicações Wine a partir de um template, recebendo nome, executável e ícone.            |
| [copy-path.sh](./copy-path.sh)                     | Copia o caminho absoluto de um arquivo ou diretório para a área de transferência usando `wl-copy`.                           |

## Link simbólico

Os scripts podem ser todos tornados executáveis

```bash
chmod +x <arquivo>.sh
```

e adicionados a um diretório no `PATH` para fácil acesso. Por exemplo, você pode criar um link simbólico para cada script em `$HOME/.local/bin`:

```bash
ln -s /caminho/para/shell-scripts/hello-world.sh $HOME/.local/bin/hello-world
```

Isso permitirá que você execute o script simplesmente digitando `hello-world` no terminal, de qualquer lugar do sistema. Repita esse processo para cada script que deseja tornar acessível globalmente.
