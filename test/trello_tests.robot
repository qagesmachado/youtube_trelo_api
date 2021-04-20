*** Settings ***
Library    RequestsLibrary
Resource   ../resources/auth.robot
Resource   ../resources/requests.robot

# Exercício
# 1. O usuário deve realizar a autenticação no Trello APIs (obter token de acesso).
# 2. O usuário deve criar um card e editar esse card.
# 3. O usuário deve excluir esse card e também as sujeiras geradas por esta automação.

# Keyword "Creating Session" comtepla o Exercício 1
Suite Setup         Creating Session    trello    url=https://api.trello.com
Suite Teardown      Delete All Sessions
Test Teardown       Run Keyword If Test Failed    Fatal Error

*** Variables ***

*** Test Cases ***
# Setup para  Exercicio 2
Test 1 - Criar um board e suas listas
  Create a Board  ${my_api_key}  ${my_token_trello}  Test board API Trello
  Create a List    ${my_api_key}  ${my_token_trello}  Test board API Trello    Done
  Create a List    ${my_api_key}  ${my_token_trello}  Test board API Trello    Coding
  Create a List    ${my_api_key}  ${my_token_trello}  Test board API Trello    To Do

# # Exercicio 2
Test 2 - Criar um card
  Create a Card    ${my_api_key}     ${my_token_trello}    Test board API Trello  To Do   Card 1
  Create a Card    ${my_api_key}     ${my_token_trello}    Test board API Trello  Coding  Card 2
  Create a Card    ${my_api_key}     ${my_token_trello}    Test board API Trello  Done    Card 3

Test 3 - Editar o card
  Change Card Position on List    ${my_api_key}     ${my_token_trello}    Test board API Trello  To Do  Coding    Card 1
  Change Card Position on List    ${my_api_key}     ${my_token_trello}    Test board API Trello  Coding  Done    Card 1

Test 4 - Excluir o card
  Delete a Card    ${my_api_key}     ${my_token_trello}    Test board API Trello  Done  Card 1
  Delete a Card    ${my_api_key}     ${my_token_trello}    Test board API Trello  Coding  Card 2
  Delete a Card    ${my_api_key}     ${my_token_trello}    Test board API Trello  Done  Card 3

# Exercicio 3
Test 5 - Deletar board
  Delete a Board    ${my_api_key}  ${my_token_trello}  Test board API Trello

*** Keywords ***
