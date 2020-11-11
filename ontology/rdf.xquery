(: Run with:
saxonb-xquery -s:index.html -q:rdf.xquery -t '!method=text' > onto.ttl
:)
declare namespace xhtml = "http://www.w3.org/1999/xhtml" ;
declare function local:definition($elem as element(), $lang as xs:string) as xs:string {
  string-join(
    $elem /.. / .. / .. / xhtml:tr
                  [xhtml:td / text() [contains(., concat("Definition@",$lang))] ]
               / xhtml:td [not(./@class)] / text()
    , ' ')
};

let $prefixes := "@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
"
let $triples :=
  for $a in //xhtml:td/xhtml:a
    let $type := $a /.. / .. / .. / xhtml:tr/xhtml:th /xhtml:span/text()
    let $lab  := $a /.. / .. / .. / xhtml:tr/xhtml:th / text()
    let $def_en  := local:definition($a, "en")
    let $def_fr  := local:definition($a, "fr")
    let $def0 := $a /.. / .. / .. / xhtml:tr
                  [xhtml:td / text() [contains(., "Definition")] ]
               / xhtml:td [not(./@class)] / text()
    let $uri := $a/@href
    let $xsd := "http://www.w3.org/2001/XMLSchema#"
    let $owl := "http://www.w3.org/2002/07/owl#"
    let $skos := "http://www.w3.org/2004/02/skos/core#Concept"
    return (
      if ( starts-with( $type, "SKOS") ) then
        concat( "<", $uri, ">", " a ", "<", $skos, "> .", '&#xA;' )
      else 
        concat( "<", $uri, ">", " a ", "<", $owl, $type, "> .", '&#xA;' ) ,
        concat( "<", $uri, ">", " rdfs:label ",   '"""', string-join($lab, ' '), '""" .', '&#xA;' ) ,
        concat( "<", $uri, ">", " rdfs:comment ", '"""', string-join($def_en, ' '), '"""@en .', '&#xA;' ) ,
        concat( "<", $uri, ">", " rdfs:comment ", '"""', string-join($def_fr, ' '), '"""@fr .', '&#xA;' ) 
    )
for $item in ( $prefixes , $triples ) return $item

