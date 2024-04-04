*** Settings ***

Resource    ../common_resource.robot


*** Variables ***

#Rotas
${ENDPOINT_CREATE_PRODUCT}    ${URL}/produtos
${ENDPOINT_SEARCH_PRODUCT}    ${URL}/produtos/

#Variáveis
${F_PRODUCT_NAME}             Logitech Lift - 
${S_PRODUCT_NAME}             Pebble Keys 2 - 

${F_PRODUCT_DESCRIPTION}      Mouse
${S_PRODUCT_DESCRIPTION}      Keyboard
    
    
*** Keywords ***

Creates the product data request

    #Definição dos atributos aleatórios
    ${F_PRODUCT_ID}             FakerLibrary.Random Number    digits=10
    ${S_PRODUCT_ID}             FakerLibrary.Random Number    digits=10
    ${F_PRODUCT_PRICE}          FakerLibrary.Random Number    digits=3
    ${S_PRODUCT_PRICE}          FakerLibrary.Random Number    digits=3
    ${F_PRODUCT_AMOUNT}         FakerLibrary.Random Number    digits=1
    ${S_PRODUCT_AMOUNT}         FakerLibrary.Random Number    digits=1

    #Criação do body do primeiro produto
    ${BODY_MODEL_F_PRODUCT}    Set Variable    {"nome": "${F_PRODUCT_NAME}${F_PRODUCT_ID}", "preco": ${F_PRODUCT_PRICE}, "descricao": "${F_PRODUCT_DESCRIPTION}", "quantidade": ${F_PRODUCT_AMOUNT}}

    #Criação do body do segundo produto
    ${BODY_MODEL_S_PRODUCT}    Set Variable    {"nome": "${S_PRODUCT_NAME}${S_PRODUCT_ID}", "preco": ${S_PRODUCT_PRICE}, "descricao": "${S_PRODUCT_DESCRIPTION}", "quantidade": ${S_PRODUCT_AMOUNT}}

    #Definição de variáveis de contexto do teste
    Set Test Variable    ${BODY_MODEL_F_PRODUCT}
    Set Test Variable    ${BODY_MODEL_S_PRODUCT}
    Set Test Variable    ${F_PRODUCT_AMOUNT}
    Set Test Variable    ${S_PRODUCT_AMOUNT}


Create the products

    #Requisição de criação do primeiro produto
    ${CREATE_PRODUCT_REQUEST}    Http    url=${ENDPOINT_CREATE_PRODUCT}
    ...                                  method=${POST}
    ...                                  body=${BODY_MODEL_F_PRODUCT}
    ...                                  headers={"authorization":"${TOKEN}"}

    #Verificação do status code retornado
    Should Be Equal As Integers       ${CREATE_PRODUCT_REQUEST["status"]}    ${CREATED}

    #Armazenando o ID do primeiro produto criado em uma variável de contexto do teste
    ${F_PRODUCT_ID}      Set Variable       ${CREATE_PRODUCT_REQUEST["body"]['_id']}
    Set Test Variable    ${F_PRODUCT_ID}

    #Requisição de criação do segundo produto
    ${CREATE_PRODUCT_REQUEST}    Http    url=${ENDPOINT_CREATE_PRODUCT}
    ...                                  method=${POST}
    ...                                  body=${BODY_MODEL_S_PRODUCT}
    ...                                  headers={"authorization":"${TOKEN}"}

    #Verificação do status code retornado
    Should Be Equal As Integers       ${CREATE_PRODUCT_REQUEST["status"]}    ${CREATED}
    
    #Armazenando o ID do segundo produto criado em uma variável de contexto do teste
    ${S_PRODUCT_ID}      Set Variable       ${CREATE_PRODUCT_REQUEST["body"]['_id']}
    Set Test Variable    ${S_PRODUCT_ID}

    #Implementação futura: Definir a quantidade de produtos criados como variável.

Check if the product was created
    
    #Verifica a criação real do primeiro produto
    ${SEARCH_PRODUCT_REQUEST}    Http    url=${ENDPOINT_SEARCH_PRODUCT}${F_PRODUCT_ID}
    ...                                  method=${GET}

    #Verificação do status code retornado
    Should Be Equal As Integers       ${SEARCH_PRODUCT_REQUEST["status"]}    200    #Bug: Deveria ser 201.

    #Verifica a criação real do segundo produto
    ${SEARCH_PRODUCT_REQUEST}    Http    url=${ENDPOINT_SEARCH_PRODUCT}${S_PRODUCT_ID}
    ...                                  method=${GET}

    #Verificação do status code retornado
    Should Be Equal As Integers       ${SEARCH_PRODUCT_REQUEST["status"]}    200    #Bug: Deveria ser 201.


Quantities must be debited from stock

    #Verifica quantidade do primeiro produto após a compra realizada com sucesso
    ${SEARCH_F_PRODUCT_REQUEST}    Http    url=${ENDPOINT_SEARCH_PRODUCT}${F_PRODUCT_ID}
    ...                                    method=${GET}
    
    #Verifica se houve a subtração real do primeiro produto no estoque
    ${F_PRODUCT_FINAL_AMOUNT}    Set Variable                 ${SEARCH_F_PRODUCT_REQUEST["body"]['quantidade']}
    Should Be Equal              ${F_PRODUCT_FINAL_AMOUNT}    ${F_PRODUCT_AMOUNT - 1}

    #Verifica quantidade do segundo produto após a compra realizada com sucesso
    ${SEARCH_S_PRODUCT_REQUEST}    Http    url=${ENDPOINT_SEARCH_PRODUCT}${S_PRODUCT_ID}
    ...                                    method=${GET}

    #Verifica se houve a subtração real do segundo produto no estoque
    ${S_PRODUCT_FINAL_AMOUNT}    Set Variable                 ${SEARCH_S_PRODUCT_REQUEST["body"]['quantidade']}
    Should Be Equal              ${S_PRODUCT_FINAL_AMOUNT}    ${S_PRODUCT_AMOUNT - 1}