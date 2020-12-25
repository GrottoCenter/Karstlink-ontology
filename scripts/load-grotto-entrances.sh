# la boucle shell qui charge dans semantic_forms les /entrances/NNN via /load-uri?url=     et    /json2rdf?src=

SERVER=http://localhost:9000
API=https://beta.grottocenter.org/api/v1/entrances
COUNT=3 # 80000
OFFSET=10 # 1

declare -i END
END=$OFFSET+$COUNT

for (( item=$OFFSET; item<=$END; item+=1 ));
do
  echo "======== Loading <$API/$item> ========"
  curl \
    --data-urlencode url=$SERVER/json2rdf?src=$API/$item \
    $SERVER/load-uri
  sleep 5 ; echo
done
