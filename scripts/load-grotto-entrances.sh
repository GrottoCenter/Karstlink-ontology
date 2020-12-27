#!/bin/bash

# la boucle shell qui charge dans semantic_forms les /entrances/NNN via /load-uri?url=     et    /json2rdf?src=

SERVER=http://localhost:9000
API=https://beta.grottocenter.org/api/v1/entrances
COUNT=10000 # 80000
OFFSET=1795 # 1773 # 1628 # 1

declare -i END
END=$OFFSET+$COUNT

for (( item=$OFFSET; item<=$END; item+=1 ));
do
  echo "======== Loading <$API/$item> ========"
  # /usr/bin/time -f " Elapsed %E" curl \
  time curl \
    --data-urlencode url=$SERVER/json2rdf?src=$API/$item \
    $SERVER/load-uri
  # sleep 1 ; 
  # echo
done
