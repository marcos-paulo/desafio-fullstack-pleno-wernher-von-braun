# Requisitos Funcionais:

- [ ] 1. Os usuários devem poder autenticar-se na aplicação para poder configurar e
     acessar os dados de monitoramento dos dispositivos
     - [ ] criar backend de login
     - [ ] criar tela de login
- [ ] 2. A aplicação deve ter uma funcionalidade de seleção de dispositivos, na qual são
     apresentados todos os dispositivos cadastrados na plataforma e o usuário pode
     configurar aqueles que deseja monitorar.
     - [ ] criar backend de dispositivos
     - [ ] criar tela de listar todos os dispositivos
     - [ ] incluir funcionalidade de selecionar dispositivos que farão parte da visualização
- [ ] 3. Para cada dispositivo que o usuário selecione para monitorar, a aplicação deve
     apresentar uma tela na qual seja possível indicar qual ou quais comandos
     disponibilizados pelo dispositivos devem ser utilizados;
     - [ ] criar backend de listar comandos do dispositivo
     - [ ] criar tela de listar comandos do dispositivo
- [ ] 4. A aplicação deve ter um dashboard de consulta, na qual são listados todos os
     dispositivos selecionados na interface definida em 2 e, para cada dispositivo, a
     resposta de cada um dos comandos selecionados em 3;
- [ ] 5. O acesso aos dados do dispositivo deve ser realizado utilizando o protocolo telnet,
     para a url cadastrada, enviando-se o comando selecionado e coletando a resposta.
- [ ] 6. A aplicação deve aplicar métodos para otimizar as requisições e reduzir o tempo de
     resposta.

# Entregáveis:

- [ ] 1. Código Fonte: Repositório no Github do candidato, contendo o código fonte do
     projeto criado
- [ ] 2. Explicação de Decisões de Design e Implementação: O arquivo README do
     repositório Git deve detalhar, de forma clara, as decisões de design e
     implementação adotadas no projeto, bem como sugestões de melhorias e avanços
     futuros. É importe o candidato organizar adequadamente essas informações para
     que seja fácil identificá-las e avaliá-las
- [ ] 3. Sugestões de melhorias e aperfeiçoamentos na API apresentada no anexo.
