*** Settings ***

#Importação dos recursos necessários
Resource    ../common_resource.robot


*** Variables ***

#Rotas
${ENDPOINT_CREATE_USER}    ${URL}/usuarios
${ENDPOINT_SEARCH_USER}    ${URL}/usuarios/
${ENDPOINT_LOGIN}          ${URL}/login

#Variável
${USER_TYPE}               true
    
    
*** Keywords ***

Creates the user data request
    
    #Criação das variáveis aleatórias
    ${USER_NAME}          FakerLibrary.Name
    ${USER_EMAIL}         FakerLibrary.Email
    ${USER_PASSWORD}      FakerLibrary.Password

    #Criação do corpo da requisição de criação de usuário com os dados gerados aleatóriamente
    ${BODY_MODEL_USER}    Set Variable    {"nome": "${USER_NAME}", "email": "${USER_EMAIL}", "password": "${USER_PASSWORD}", "administrador": "${USER_TYPE}"}

    #Criação do corpo da requisição de login
    ${BODY_MODEL_LOGIN}    Set Variable    {"email": "${USER_EMAIL}", "password": "${USER_PASSWORD}"}

    #Definindo variáveis no contexto do teste
    Set Test Variable    ${USER_NAME}
    Set Test Variable    ${USER_EMAIL}
    Set Test Variable    ${USER_PASSWORD}
    Set Test Variable    ${BODY_MODEL_USER}
    Set Test Variable    ${BODY_MODEL_LOGIN}

Create the user
    
    #Requisição para criação de usuário
    ${CREATE_USER_REQUEST}    Http    url=${ENDPOINT_CREATE_USER}
    ...                               method=${POST}
    ...                               body=${BODY_MODEL_USER}

    #Verificação do status code retornado
    Should Be Equal As Integers       ${CREATE_USER_REQUEST["status"]}    ${CREATED}
    
    #Armazenando o ID do usuário criado em uma variável de contexto do teste
    ${USER_ID}           Set Variable    ${CREATE_USER_REQUEST["body"]['_id']}
    Set Test Variable    ${USER_ID}

Check if the user was created

    #Requisição verificação da criação real do usuário
    ${SEARCH_USER_REQUEST}    Http    url=${ENDPOINT_SEARCH_USER}${USER_ID}
    ...                               method=${GET}

    #Verificação do status code retornado
    Should Be Equal As Integers       ${SEARCH_USER_REQUEST["status"]}    ${SUCCESS}


Login with user credentias

    #Requisição de login para aquisição do token de autenticação
    ${CREATE_LOGIN_REQUEST}    Http    url=${ENDPOINT_LOGIN}
    ...                                method=${POST}
    ...                                body=${BODY_MODEL_LOGIN}
    
    #Verificação do status code retornado
    Should Be Equal As Integers        ${CREATE_LOGIN_REQUEST["status"]}    ${SUCCESS}

    #Armazenando o token do usuário em uma variável de contexto do teste
    ${TOKEN}             Set Variable     ${CREATE_LOGIN_REQUEST["body"]["authorization"]}
    Set Test Variable    ${TOKEN}