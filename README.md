<div align="center">

<img src="https://github.com/julianakcm1/Microcontrollers/assets/54086293/87d97993-e9fd-4dc4-a664-935755806701" width="100" height="100">

# Microcontroladores <br>
**Grupo C**<br>

</div>

<p align="center">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#-project">Projeto</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-description">Descrição</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-tech">Tecnologias</a><br><br>
</p>

<div id="-project">

## :computer: Projeto

Projeto desenvolvido para a disciplina de Microcontroladores do Instituto de Computação da Universidade Federal de Alagoas.

Os assuntos vistos e utilizados neste projeto foram:
  
- Linguagem Assembly
- Representação de dados
- Estruturas de controle
- Pilha
- Chamadas de função
- Interrupções
- Timer
- Comunicação serial com USART
- Interface com display de 7 segmentos

</div>

<div id="-description">

## :page_facing_up: Descrição

**Objetivo**<br>
Implementar em assembly do AVR um código que simule o funcionamento de um elevador para um prédio de 2 andares (térreo + 2).<br><br>

**Requisitos**<br>
- Priorizar os andares mais altos caso tenham duas chamadas<br>
*Exemplo:* Se estiver no térreo subindo para o 2º andar, não deve parar no 1º andar, mesmo que o botão que fica no primeiro andar tenha sido pressionado antes de o carro do elevador passar pelo 1° andar.<br>
*Obs:* Essa prioridade não acontece para os botões dentro do elevador.<br>

- Se a porta do elevador ficar aberta por 5 segundos, toca-se o Buzzer
- Se a porta do elevador ficar aberta por 10 segundos, deve ser fechada automaticamente
- O elevador leva 3 segundos de um andar para o outro
- Deve-se utilizar os Timers do AVR para definir os tempos. Deve-se utilizar interrupção ao invés de verificação de flag
  
</div>

<div id="-tech">

## :rocket: Tecnologias

Esse projeto foi desenvolvido com as seguintes tecnologias:

- SimulIDE 
- Microchip Studio
- VS Code
- Git
- Github

</div>
