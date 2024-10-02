*** Settings ***
Library  Browser

*** Variables ***
${URL}      http://localhost:8080
${WAIT_TIME}  10s

*** Test Cases ***
Test Increment Counter
    # Abrir o navegador e carregar a aplicação Flutter web
    New Browser  chromium
    New Page  ${URL}
    Set Viewport Size  1920  1080
    
    # Verificar se o título da página principal está presente
    Wait For Elements State  xpath=//*[@role='heading' and contains(., 'Flutter Demo Home Page')]  visible  ${WAIT_TIME}
    
    # Verificar se a descrição do contador está presente
    Wait For Elements State  xpath=//flt-semantics[span[contains(text(), 'You have pushed the button this many times:')]]  visible  ${WAIT_TIME}
    
    # Verificar se o contador inicial é 0
    Wait For Elements State  xpath=//flt-semantics[@id='flt-semantic-node-5']  visible  ${WAIT_TIME}
    ${initial_value}=  Get Text  xpath=//flt-semantics[@id='flt-semantic-node-5']/span
    Should Be Equal  ${initial_value}  0

    # Clicar no botão de incremento
    Wait For Elements State  xpath=//flt-semantics[@aria-label='incrementButton']//flt-semantics[@role='button']  visible  ${WAIT_TIME}
    Click  xpath=//flt-semantics[@aria-label='incrementButton']//flt-semantics[@role='button']
    
    # Aguardar um breve momento para garantir a atualização
    Sleep  1s

    # Verificar se o contador incrementa para 1
    Wait For Elements State  xpath=//flt-semantics[@id='flt-semantic-node-5']  visible  ${WAIT_TIME}
    ${incremented_value}=  Get Text  xpath=//flt-semantics[@id='flt-semantic-node-5']/span
    Should Be Equal  ${incremented_value}  1

    # Clicar novamente no botão de incremento
    Wait For Elements State  xpath=//flt-semantics[@aria-label='incrementButton']//flt-semantics[@role='button']  visible  ${WAIT_TIME}
    Click  xpath=//flt-semantics[@aria-label='incrementButton']//flt-semantics[@role='button']
    
    # Aguardar novamente para garantir a atualização
    Sleep  1s

    # Verificar se o contador incrementa para 2
    Wait For Elements State  xpath=//flt-semantics[@id='flt-semantic-node-5']  visible  ${WAIT_TIME}
    ${incremented_value_2}=  Get Text  xpath=//flt-semantics[@id='flt-semantic-node-5']/span
    Should Be Equal  ${incremented_value_2}  2
    
    # Fechar o navegador
    Close Browser
