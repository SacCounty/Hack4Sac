import React, { Component } from 'react';
import { NICE, SUPER_NICE } from '../colors';
import { Map, Marker, Popup, TileLayer } from 'react-leaflet'
import request from 'superagent'
require('../lib/tota11y.min.js')

export class AppMap extends Component {

  constructor(props) {
    super(props)

    request
      .get('http://saccounty.cloudapi.junar.com/api/v2/datastreams/SACRA-COUNT/data.json/?auth_key=365e06cd12a419135ae87d9f0ec0a8e60b25fbe3#sthash.qxY4OVZH.dpuf')
      .end((err, res) => {
        this.polygon = res.body.result.fArray[2].fStr.split(' ')
      })
  }

  getStyles() {
    return {
      root: {
        height: '100vh'
      },
      map: {
        height: '100%'
      }
    }
  }

  render() {
    let styles = this.getStyles()
    const position = [38.5556, -121.4689]
    return (
      <div style={styles.root}>
        <Map center={position} zoom={13} style={styles.map}>
          <TileLayer
            url='http://{s}.tile.osm.org/{z}/{x}/{y}.png'
            attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
          />
          <Marker position={position}>
            <Popup>
              <span>A pretty CSS3 popup.<br/>Easily customizable.</span>
            </Popup>
          </Marker>
        </Map>
      </div>
    );
  }
}
