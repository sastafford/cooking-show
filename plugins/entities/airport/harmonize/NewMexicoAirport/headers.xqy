xquery version "1.0-ml";

module namespace plugin = "http://marklogic.com/data-hub/plugins";

declare namespace es = "http://marklogic.com/entity-services";
declare namespace kml = "http://earth.google.com/kml/2.2";

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
  (
  element point {
    attribute classification { "UNCLASSIFIED" },
    $content//kml:Point/kml:coordinates/text()
  },
  element elevation { $content//kml:SimpleData[@name = "ELEVATN"]/text() }
  )

};
