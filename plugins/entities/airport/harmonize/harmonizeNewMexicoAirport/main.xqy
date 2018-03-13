xquery version "1.0-ml";

(: Your plugin must be in this namespace for the DHF to recognize it:)
module namespace plugin = "http://marklogic.com/data-hub/plugins";

(:
 : This module exposes helper functions to make your life easier
 : See documentation at:
 : https://github.com/marklogic/marklogic-data-hub/wiki/dhf-lib
 :)
import module namespace dhf = "http://marklogic.com/dhf"
  at "/com.marklogic.hub/dhf.xqy";

(: include modules to construct various parts of the envelope :)
import module namespace content = "http://marklogic.com/data-hub/plugins" at "content.xqy";
import module namespace headers = "http://marklogic.com/data-hub/plugins" at "headers.xqy";
import module namespace triples = "http://marklogic.com/data-hub/plugins" at "triples.xqy";

(: include the writer module which persists your envelope into MarkLogic :)
import module namespace writer = "http://marklogic.com/data-hub/plugins" at "writer.xqy";

declare namespace kml = "http://earth.google.com/kml/2.2";

declare option xdmp:mapping "false";

(:~
 : Plugin Entry point
 :
 : @param $id          - the identifier returned by the collector
 : @param $options     - a map containing options. Options are sent from Java
 :
 :)
declare function plugin:main(
  $id as xs:string,
  $options as map:map)
{
  let $content-context := dhf:content-context()
  let $content := dhf:run($content-context, function() {
    content:create-content($id, $options)
  })

  for $placemark in $content//kml:Placemark
  let $new-uri := fn:concat("/airports/new-mexico/", $placemark/@id, ".xml")
  let $_ := xdmp:log($id)
  let $_ := xdmp:log($new-uri)
  let $header-context := dhf:headers-context($placemark)
  let $headers := dhf:run($header-context, function() {
    headers:create-headers($new-uri, $placemark, $options)
  })

  let $triple-context := dhf:triples-context($placemark, $headers)
  let $triples := dhf:run($triple-context, function() {
    triples:create-triples($new-uri, $placemark, $headers, $options)
  })

  let $envelope := dhf:make-envelope($placemark, $headers, $triples, map:get($options, "dataFormat"))
  return
    (: writers must be invoked this way.
     see: https://github.com/marklogic-community/marklogic-data-hub/wiki/dhf-lib#run-writer :)
    dhf:run-writer(xdmp:function(xs:QName("writer:write")), $new-uri, $envelope, $options)
};
