# trello_api

## Documentação para execução

### Comandos de execução
Ir para a pasta do projeto e de executar os comandos a seguir:
Testes devem ser executados na ordem proposta

### Comando para executar todos os testes de um só vez
* robot -d .\results -L trace test\trello_tests.robot

### Comando para executar um teste de cada vez
* robot -d .\results -L trace -t "Test 1 - Criar um board e suas listas" test\trello_tests.robot
* robot -d .\results -L trace -t "Test 2 - Criar um card" test\trello_tests.robot
* robot -d .\results -L trace -t "Test 3 - Editar o card" test\trello_tests.robot
* robot -d .\results -L trace -t "Test 4 - Excluir o card" test\trello_tests.robot
* robot -d .\results -L trace -t "Test 5 - Deletar board" test\trello_tests.robot


## Environment de teste
pip freeze:
* robotframework==4.0.1
* robotframework-databaselibrary==1.2.4
* robotframework-datadriver==0.3.6
* robotframework-jsonlibrary==0.3.1
* robotframework-requests==0.6.3
* robotframework-seleniumlibrary==5.1.3

python --version
* Python 3.7.3

### Autenticação
Acessar https://developer.atlassian.com/cloud/trello/guides/rest-api/api-introduction/
e obter seu próprio api_key, token_trello e username
Após isso adiciona-los no arquivo \resources\auth.robot

### Sistema Operacional
Windows
