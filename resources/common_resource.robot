*** Settings ***

Library     Browser          #Biblioteca responsável por implementar o playwright ao robot.
Library     FakerLibrary     #Biblioteca responsável por gerar dados aleatórios.

*** Variables ***

#Configurações
${BROWSER}     chromium    #Define em qual motor o teste será realizado (chromium, firefox, webkit)
${HEADLESS}    ${True}    #Para visualizar o processo de teste deixar o "headless" = false, caso não "true".

#URL
${URL}    https://serverest.dev

#Métodos
${GET}       GET
${POST}      POST
${DELETE}    DELETE

#Status
${SUCCESS}    200
${CREATED}    201


*** Keywords ***

Open Browser

    [Arguments]    ${URL}
    
    New Browser    ${BROWSER}    ${HEADLESS}    slowMo=0:00:01
    New Context    viewport={"width": 1366, "height": 810}
    New Page       ${URL}