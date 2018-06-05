xquery version "1.0-ml";

module namespace plugin = "http://marklogic.com/data-hub/plugins";

declare namespace es = "http://marklogic.com/entity-services";
declare namespace gml="http://www.opengis.net/gml";
declare namespace fme="http://www.safe.com/gml/fme";

declare option xdmp:mapping "false";

(:~
 : Create Headers Plugin
 :
 : @param $id      - the identifier returned by the collector
 : @param $content - the output of your content plugin
 : @param $options - a map containing options. Options are sent from Java
 :
 : @return - zero or more header nodes
 :)
declare function plugin:create-headers(
  $id as xs:string,
  $content as item()?,
  $options as map:map) as node()*
{
  let $airport := map:get($content, "airport")
  return
  (
    element point {
      attribute classification { "UNCLASSIFIED" },
      attribute compartmentation { "FOUO" },
      $airport//gml:Point/gml:pos//text()
    },
    let $elevation := $airport//fme:ELEV/text()
    return
      if (fn:empty($elevation)) then ()
      else
        element elevation { $elevation }
  )
};
