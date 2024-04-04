*** Settings ***

Resource    ../common_resource.robot


*** Variables ***

#Rotas
${ENDPOINT_CREATE_CART}     ${URL}/carrinhos
${ENDPOINT_SEARCH_CART}     ${URL}/carrinhos/
${ENDPOINT_CONFIRM_CART}    ${URL}/carrinhos/concluir-compra
   
    
*** Keywords ***

Select products to purchase

    #Criação do body da criação do carrinho com os produtos criados
    ${BODY_BUY_PRODUTCS}    Set Variable    {"produtos":[{"idProduto": "${F_PRODUCT_ID}", "quantidade": 1},{"idProduto": "${S_PRODUCT_ID}","quantidade": 1}]}
    #Implementação futura: definir quantidade de produtos como variável aleatória consultando a quantidade disponível de produtos.

    #Definição de variável de contexto do teste
    Set Test Variable    ${BODY_BUY_PRODUTCS}


Register the cart with the selected products

    #Criação do body da criação do carrinho com os produtos criados
    ${CREATE_CART_REQUEST}    Http    url=${ENDPOINT_CREATE_CART}
    ...                               method=${POST}
    ...                               body=${BODY_BUY_PRODUTCS}
    ...                               headers={"authorization":"${TOKEN}"}

    #Verificação do status code retornado
    Should Be Equal As Integers       ${CREATE_CART_REQUEST["status"]}    ${CREATED}

    #Armazenando o ID do carrinho criado em uma variável de contexto do teste
    ${CART_ID}           Set Variable    ${CREATE_CART_REQUEST["body"]['_id']}
    Set Test Variable    ${CART_ID}


The cart must be registered successfully

    #Verifica a criação real do carrinho
    ${SEARCH_CART_REQUEST}    Http    url=${ENDPOINT_SEARCH_CART}${CART_ID}
    ...                               method=${GET}

    #Verificação do status code retornado
    Should Be Equal As Integers       ${SEARCH_CART_REQUEST["status"]}    ${SUCCESS}


Complete the shopping cart

    #Requisição de confirmação do carrinho
    ${CONFIRM_CART_REQUEST}    Http    url=${ENDPOINT_CONFIRM_CART}
    ...                                method=${DELETE}
    ...                                headers={"authorization":"${TOKEN}"}

    #Armazenando o ID do carrinho criado em uma variável de contexto do teste
    Set Test Variable    ${CONFIRM_CART_REQUEST}


The cart is completed successfully

    #Verificação do status code retornado
    Should Be Equal As Integers        ${CONFIRM_CART_REQUEST["status"]}    ${SUCCESS}