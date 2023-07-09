*** Settings ***
Library    RequestsLibrary

*** Variables ***


*** Keywords ***
CRIAR Sessão
  [arguments]  ${alias}  ${url}
  
  ${header}    Create Dictionary    Content-Type=application/json

  Create Session      alias=${alias}    url=${url}    headers=${header}    verify=True

Deletar Sessão
  Delete All Sessions
