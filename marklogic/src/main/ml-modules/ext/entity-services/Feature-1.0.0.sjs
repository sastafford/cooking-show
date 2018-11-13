'use strict';

const geojson = require('/MarkLogic/geospatial/geojson.xqy');


module.exports = {
 extractInstanceFeature: function(source) {
    const doc = 
    {
      envelope: { 
        instance: { 
          info: {
            title: 'feature',
            version: '1.0.0'
          },
          feature: {
            name: source.properties.name,
            point: geojson.parseGeojson(source.geometry),
            source: source.properties.source,
            borough: source.properties.borough
          }
        },
        attachments: {
          source
        }
      }
    };
    return doc;
  }
}
