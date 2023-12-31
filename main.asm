; Definições de constantes para os andares
.equ TERREO = 0
.equ PRIMEIRO_ANDAR = 1
.equ SEGUNDO_ANDAR = 2

; Definições de constantes para os botões
.equ BOTAO_FECHAR_PORTA = 0
.equ BOTAO_ABRIR_PORTA = 1
.equ BOTAO_CHAMAR_TERREO = 0 ; externo
.equ BOTAO_CHAMAR_PRIMEIRO_ANDAR = 1 ; externo
.equ BOTAO_CHAMAR_SEGUNDO_ANDAR = 2 ; externo
.equ BOTAO_IR_TERREO = 0 ; interno
.equ BOTAO_IR_PRIMEIRO_ANDAR = 1 ; interno
.equ BOTAO_IR_SEGUNDO_ANDAR = 2 ; interno

; Definições de constantes de tempo
.equ TEMPO_PORTA_ABERTA= 5000  ; 5 segundos (em milissegundos)
.equ TEMPO_PORTA_FECHADA = 10000  ; 10 segundos (em milissegundos)
.equ TEMPO_VIAGEM_ANDAR = 3000  ; 3 segundos (em milissegundos)

; Variáveis globais
.def contador_tempo_porta = r18
.def chamada_pendente = r19
.def buzzer_tempo = r20
.def tempo_viagem = r21
.def destino = r22
.def andar_atual = r23
.def estado_porta = r24

.def temp = r16
.def display = r17 ;current LED value

#define clock 16.0e6 ;clock speed
.equ baudRate 9600

jmp reset
.org OC1Aaddr
jmp OC1A_Interrupt

OC1A_Interrupt:
  push r16
  in r16, SREG
  push r16
 
  inc display
 
  pop r16
  out SREG, r16
  pop r16
  reti

reset:
  ;Stack initialization
  ldi temp, low(RAMEND)
  out SPL, temp
  ldi temp, high(RAMEND)
  out SPH, temp


  sei

interrupcao_externa:
  ldi temp, (1 << ISC01) | (1 << ISC00) ; INT0
  out EICRA, temp

  ldi r16, (1 << INT0) | (1 << INT1) ; Habilitar interrupção externa INT0 e INT1
  out EIMSK, temp

  ret

timers:
  lds r16, TIMSK1
  sbr r16, 1 <<OCIE1A
  sts TIMSK1, r16

  .equ PRESCALE = 0b100 ;/256 prescale
  .equ PRESCALE_DIV = 256
  #define DELAY 1 ;seconds
  .equ WGM = 0b0100 ;Waveform generation mode: CTC
  ;you must ensure this value is between 0 and 65535
  .equ TOP = int(0.5 + ((CLOCK/PRESCALE_DIV)*DELAY))
  .if TOP > 65535
  .error "TOP is out of range"
  .endif

  ;On MEGA series, write high byte of 16-bit timer registers first
  ldi temp, high(TOP) ;initialize compare value (TOP)
  sts OCR1AH, temp
  ldi temp, low(TOP)
  sts OCR1AL, temp

  ldi temp, ((WGM&0b11) << WGM10) ;lower 2 bits of WGM
  sts TCCR1A, temp
  ;upper 2 bits of WGM and clock select
  ldi temp, ((WGM>> 2) << WGM12)|(PRESCALE << CS10)
  sts TCCR1B, temp ;start counter
  sei;

usart:
  ;16 mhz clock speed, 9600 baud UBRR = 103

  .cseg

  .equ UBRRvalue = clock / (16 * baudRate) - 1

  ldi temp, high (UBRRvalue) ;baud rate
  sts UBRR0H, temp
  ldi temp, low (UBRRvalue)
  sts UBRR0L, temp

  ret