#! /bin/bash

cap () {
  awk 'BEGIN { split("a the to at in on with and but or", w)
          for (i in w) nocap[w[i]] }

  function cap(word) {
      return toupper(substr(word,1,1)) tolower(substr(word,2))
  }

  {
    for (i=1; i<=NF; ++i) {
        printf "%s%s", (i==1||i==NF||!(tolower($i) in nocap)?cap($i):tolower($i)),
                       (i==NF?"\n":" ")
    }
  }'
}

paste -d '|' - - - | tac |
while read line; do
  d=$(echo $line | cut -d '|' -f 1 | xargs -n 3 echo)
  d=$(date -jf "%b %e, %Y" "+%Y-%m-%d" "$d")

  store=$(echo $line | cut -d '|' -f 2)
  store=$(echo $store | cut -d '#' -f 1 | cut -d ',' -f 1 | cap)
  cost=$(echo $line | cut -d '|' -f 3)

  echo "$d $store"
  echo "  e:   $cost"
  echo "  c:rbc:Visa"
  echo "  b:rbc:Chequing:General"
  echo ""
done
