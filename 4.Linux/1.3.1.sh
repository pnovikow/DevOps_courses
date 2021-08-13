#!/usr/bin/env bash

currencyCodes=(BYN USD EUR)

checkValidCurrency()
{
  if [[ "${currencyCodes[*]}" == *"$(echo "${@}" | tr -d '[:space:]')"* ]]; then
    echo "0"
  else
    echo "1"
  fi
}

getBase()
{
  echo -n "What is the base currency: "
  read -r base
  base=$(echo "$base" | tr /a-z/ /A-Z/)
  if [[ $(checkValidCurrency "$base") == "1" ]]; then
    unset base
    echo "Invalid base currency"
    getBase
  fi
}

getExchangeTo()
{
  echo -n "What currency to exchange to: "
  read -r exchangeTo
  exchangeTo=$(echo "$exchangeTo" | tr /a-z/ /A-Z/)
  if [[ $(checkValidCurrency "$exchangeTo") == "1" ]]; then
    echo "Invalid exchange currency"
    unset exchangeTo
    getExchangeTo
  fi
}

getAmount()
{
  echo -n "What is the amount being exchanged: "
  read -r amount
  if [[ ! "$amount" =~ ^[0-9]+(\.[0-9]+)?$ ]]
  then
    echo "The amount has to be a number"
    unset amount
    getAmount
  fi
}


convertCurrency()
{
  trueBase=$base
  trueTarget=$exchangeTo
  coef1="1"
  coef2="1"
  if [[ "$peggedBase" =~ ^[A-Z]+:[0-9.]+$ ]]; then
    trueBase=$(echo "$peggedBase" | grep -Eo "^[A-Z]*")
    coef1=$(echo "$peggedBase" | grep -Eo "[0-9.]*$")
  fi
  if [[ "$peggedTarget" =~ ^[A-Z]+:[0-9.]+$ ]]; then
    trueTarget=$(echo "$peggedTarget" | grep -Eo "^[A-Z]*")
    coef2=$(echo "$peggedTarget" | grep -Eo "[0-9.]*$")
  fi
  if [[ "$trueBase" == "$exchangeTo" || "$base" == "$trueTarget" ]]; then
    exchangeRate="1"
  else
    exchangeRate=$(wget -qO- "$@" "https://api.exchangerate-api.com/v4/latest/$trueBase" | grep -Eo "$trueTarget\":[0-9.]*" | grep -Eo "[0-9.]*") > /dev/null
  fi
  if ! command -v bc &>/dev/null; then
    exchangeRate=$(echo "$exchangeRate" | grep -Eo "^[0-9]*" )
    amount=$(echo "$amount" | grep -Eo "^[0-9]*" )
    coef1=$(echo "$coef1" | grep -Eo "^[0-9]*" )
    exchangeRate=$(( exchangeRate / coef1 ))
    exchangeRate=$(( exchangeRate * coef2 ))
    exchangeAmount=$(( exchangeRate * amount ))
  else
    exchangeRate=$( echo "scale=8; $exchangeRate / $coef1" | bc )
    exchangeRate=$( echo "$exchangeRate * $coef2" | bc )
    exchangeAmount=$( echo "$exchangeRate * $amount" | bc )
  fi

cat <<EOF
$base to $exchangeTo
Rate: $exchangeRate
$base: $amount
$exchangeTo: $exchangeAmount
EOF
}

  configuredClient="wget"
  getBase
  getExchangeTo
  getAmount
  convertCurrency

