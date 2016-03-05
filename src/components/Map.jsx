import React, { Component } from 'react';
import { NICE, SUPER_NICE } from '../colors';
import { Map, Marker, Popup, TileLayer } from 'react-leaflet'
import request from 'superagent'

export default class AppMap extends Component {

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
