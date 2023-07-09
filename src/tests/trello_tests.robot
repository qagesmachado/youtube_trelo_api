*** Settings ***
Resource    ../resources/session_rsc.robot
Resource    ../resources/board_rsc.robot
Resource    ../resources/auth.robot
Resource    ../resources/lists_rsc.robot
Resource    ../resources/cards_rsc.robot

# Keyword "Creating Session" comtepla o Exercício 1
Suite Setup         Criar Sessão    trello    url=https://api.trello.com
Suite Teardown      Deletar Sessão

*** Variables ***
# robot -d ./results -L trace  .\src\tests\trello_tests.robot
*** Test Cases ***
# Setup para  Exercicio 2
Test 1 - Fluxo Completo API TRELLO

  # BOARD
  ${board_id}    Criar Board    api_key=${my_api_key}    token_trello=${my_token_trello}    board_name=API TRELLO BOARD    resultado_esperado=200
  # Log To Console    ${board_id}
  Sleep    5s
  Listar Board por ID    api_key=${my_api_key}     token_trello=${my_token_trello}    board_id=${board_id}    resultado_esperado=200
  Editar Board    api_key=${my_api_key}     token_trello=${my_token_trello}    board_id=${board_id}     novo_nome=API TRELLO BOARD EDITADO   resultado_esperado=200
  Listar Board por ID    api_key=${my_api_key}     token_trello=${my_token_trello}    board_id=${board_id}    resultado_esperado=200
  Sleep    5s

  # LIST
  ${list_done}    Criar Lists    api_key=${my_api_key}   token_trello=${my_token_trello}  board_id=${board_id}    name_list=DONE    resultado_esperado=200
  Ler Lists    api_key=${my_api_key}     token_trello=${my_token_trello}    list_id=${list_done}     resultado_esperado=200 
  Sleep    5s

  ${list_doing}    Criar Lists    api_key=${my_api_key}   token_trello=${my_token_trello}  board_id=${board_id}    name_list=DOING    resultado_esperado=200
  Ler Lists    api_key=${my_api_key}     token_trello=${my_token_trello}    list_id=${list_doing}     resultado_esperado=200 
  Sleep    5s

  ${list_to_do}  Criar Lists  api_key=${my_api_key}   token_trello=${my_token_trello}  board_id=${board_id}    name_list=TO DO    resultado_esperado=200
  Ler Lists    api_key=${my_api_key}     token_trello=${my_token_trello}    list_id=${list_to_do}     resultado_esperado=200 
  Sleep    5s
  
  # CARD
  ${card_id}    Criar Card    ${my_api_key}    ${my_token_trello}     ${list_to_do}    Card 1    200
  Listar Card por ID    ${my_api_key}    ${my_token_trello}    ${card_id}    200
  Sleep    5s

  Mover Card    ${my_api_key}    ${my_token_trello}    ${card_id}    ${list_doing}    200
  Validar Posição do Card    ${my_api_key}    ${my_token_trello}    ${card_id}    ${list_doing}    200
  Sleep    5s

  Mover Card    ${my_api_key}    ${my_token_trello}    ${card_id}    ${list_done}    200
  Validar Posição do Card    ${my_api_key}    ${my_token_trello}    ${card_id}    ${list_done}    200
  Sleep    5s

  # Finalizando TESTE
  Deletar Card    ${my_api_key}    ${my_token_trello}    ${card_id}    200
  Listar Card por ID    ${my_api_key}    ${my_token_trello}    ${card_id}    404
  Deletar Board    api_key=${my_api_key}    token_trello=${my_token_trello}    board_id=${board_id}    resultado_esperado=200
  Listar Board por ID    api_key=${my_api_key}     token_trello=${my_token_trello}    board_id=${board_id}    resultado_esperado=404
  Sleep    5s

*** Keywords ***
