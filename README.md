# flutter_robot_framework

1. Preparar o ambiente:

``` bash
pip3 install robotframework 
pip3 install robotframework-browser
python3 -m Browser.entry init
```

2. Instalar WebDriver:

- Seguir esse tutorial [aqui](https://luizdeaguiar.com.br/pt/2022/10/instalando-chromedriver-no-path-do-macos/)

- Baixar chromebook mais atual [aqui](https://googlechromelabs.github.io/chrome-for-testing/)


3. Adicionar no main.dart logo após o runApp(const MyApp());

``` dart
if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics(); 
}
```

4. Exemplo de teste robot `main.robot`

``` robot
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
```


## Browser: principais comandos

### Comandos Comuns da Library Browser

1. New Browser
- Abre uma nova instância de navegador.
- Sintaxe: New Browser \<browser type\>
- Parâmetros:
\<browser type\>: pode ser chromium, firefox, webkit ou chrome.
- Exemplo:
`New Browser  chromium`

2. New Page
- Abre uma nova página (aba) no navegador.
- Sintaxe: New Page \<url\>
- Parâmetro: 
\<url\>: URL a ser carregada na nova aba.
- Exemplo
`New Page  http://localhost:8080`

3. Set Viewport Size
- Define o tamanho da janela do navegador.
- Sintaxe: Set Viewport Size \<width\> \<height\>
- Parâmetros:
\<width\>: largura da janela (em pixels).
\<height\>: altura da janela (em pixels).
Exemplo:
`Set Viewport Size  1920  1080`

4. Click
- Clica em um elemento.
- Sintaxe: Click \<selector\>
- Parâmetro:
\<selector\>: seletor para localizar o elemento.
- Exemplo:
`Click  xpath=//button[@id='login']`

5. Wait For Elements State
- Espera até que o estado de um elemento atinja uma condição desejada.
- Sintaxe: Wait For Elements State \<selector\> \<state\> \<timeout\>
- Parâmetros:
\<selector\>: seletor para localizar o elemento.
\<state\>: o estado esperado (visible, hidden, enabled, disabled, etc.).
\<timeout\>: tempo de espera máximo.
- Exemplo:
`Wait For Elements State  xpath=//button[@id='login']  visible  10s`

6. Get Text
- Retorna o texto de um elemento.
- Sintaxe: Get Text \<selector\>
- Parâmetro:
\<selector\>: seletor para localizar o elemento.
Exemplo:
`${text}=  Get Text  xpath=//h1[@id='title']`

7. Input Text
- Insere texto em um campo de entrada.
- Sintaxe: Input Text \<selector\> \<text\>
- Parâmetro:
\<selector\>: seletor para localizar o campo de entrada.
\<text\>: o texto a ser inserido.
- Exemplo:
`Input Text  xpath=//input[@id='username']  my_user`

8. Press Keys
Simula a pressão de teclas no elemento ou na página.
- Sintaxe: Press Keys \<selector\> \<keys\>
- Parâmetro:
\<selector\>: seletor (pode ser omitido para acionar teclas globais).
\<keys\>: uma string representando as teclas (Enter, Tab, ArrowRight, etc.).
- Exemplo:
`Press Keys  xpath=//input[@id='password']  Enter`

9. Get Title
- Retorna o título da página.
- Sintaxe: Get Title
- Exemplo:
`${title}=  Get Title`

10. Get Url
- Retorna a URL atual da página.
- Sintaxe: Get Url
- Exemplo:
`${current_url}=  Get Url`

11. Go To
- Navega para uma URL específica.
- Sintaxe: Go To \<url\>
- Parâmetro:
\<url\>: URL para a qual você deseja navegar.
Exemplo:
`Go To  https://example.com`

12. Reload
- Recarrega a página atual.
- Sintaxe: Reload
- Exemplo:
`Reload`

13. Screenshot
- Tira uma captura de tela da página atual.
- Sintaxe: Screenshot \<path\>
- Parâmetro:
\<path\>: caminho onde a captura de tela será salva.
- Exemplo:
`Screenshot  /path/to/screenshot.png`

14. Close Browser
- Fecha o navegador.
- Sintaxe: Close Browser
- Exemplo:
`Close Browser`

### Estados Aceitos pelo Wait For Elements State

- visible: o elemento está visível na tela.
- hidden: o elemento não está visível.
- enabled: o elemento está habilitado.
- disabled: o elemento está desabilitado.
- stable: o elemento parou de mudar de posição/dimensão.

### Exemplo Completo de Uso
``` robot
*** Settings ***
Library  Browser

*** Variables ***
${URL}  https://example.com
${USERNAME}  my_user
${PASSWORD}  my_password

*** Test Cases ***
Login Test
    New Browser  chromium
    New Page  ${URL}
    Set Viewport Size  1280  800
    Wait For Elements State  xpath=//input[@name='username']  visible
    Input Text  xpath=//input[@name='username']  ${USERNAME}
    Input Text  xpath=//input[@name='password']  ${PASSWORD}
    Click  xpath=//button[@type='submit']
    Wait For Elements State  xpath=//h1[text()='Welcome']  visible
    ${title}=  Get Title
    Should Be Equal  ${title}  Welcome
    Screenshot  /path/to/screenshot.png
    Close Browser
```






