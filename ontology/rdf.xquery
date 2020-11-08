(: Run with:
saxonb-xquery -s:index.html -q:rdf.xquery -t '!method=text' > onto.ttl
:)
declare namespace xhtml = "http://www.w3.org/1999/xhtml" ;
  for $a in //xhtml:td/xhtml:a
    let $type := $a /.. / .. / .. / xhtml:tr/xhtml:th /xhtml:span/text()
    let $uri := $a/@href
    let $xsd := "http://www.w3.org/2001/XMLSchema#"
    let $owl := "http://www.w3.org/2002/07/owl#"
    let $skos := "http://www.w3.org/2004/02/skos/core#Concept"
    return
if ( starts-with( $type, "SKOS") ) then
  concat( "<", $uri, ">", " a ", "<", $skos, "> .", '&#xA;' ) 
else 
  concat( "<", $uri, ">", " a ", "<", $owl, $type, "> .", '&#xA;' ) 
