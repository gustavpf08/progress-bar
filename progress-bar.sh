#!/usr/bin/env bash
# progress-bar - Barra de progresso em bash
#
# Autor:      Gustavo Paulino
# Manutenção: Gustavo Paulino
#
# ------------------------------------------------------------------------ #
#  Este programa é um exemplo de barra de progresso, feito para poder aplicar
#  os conhecimentos sobre caracteres de controle. A ideia é mostrar uma barra
#  de progresso a partir da busca de todos os arquivos na Home.
#
#  Exemplo de uso:
#      $ ./progress-bar.sh
#      [                                                  0% ]
#      [||||||||                                         19% ]

# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 28/01/2026
#     - Barra de progresso da quantidade de arquivos encontrados na home
#     - Programa apresenta cores (roxo e verde) e comportamentos (sobrescrita da
#     linha) não usuais de bash
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.2.37
#
# --------------------------- ----VARIAVEIS ----------------------------------------#

ROXO_BRILHANTE="\033[35;1m"
VERDE="\033[32;1m"

FILES=$(find ~/)
LEN=($(echo "$FILES" | wc -l))

# ------------------------------- FUNÇÕES ----------------------------------------- #

function progress-bar() {
  local current=$1
  local total=$2

  local symbol="|"
  local space=" "
  local width=50

  local porcent_progress=$((current * 100 / total))
  local progress=$((porcent_progress * width / 100))
  local out="["

  local i
  for ((i = 0; i < progress; i++)); do
    out+="$symbol"
  done

  for ((i = progress; i < width; i++)); do
    out+="$space"
  done

  out+=" $porcent_progress% ]"
  echo -ne "$VERDE$out $current/$total\r"
}
# ------------------------------- EXECUÇÃO ----------------------------------------- #

echo -e "${ROXO_BRILHANTE}Progress bar - processing all files in Home."
tput civis

for ((i = 0; i < LEN; i++)); do
  progress-bar $(($i + 1)) $LEN
done

tput cnorm
echo ""
