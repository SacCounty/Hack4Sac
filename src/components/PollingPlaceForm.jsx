import React, {Component} from 'react';
import request from 'superagent';
import { Map, Marker, Popup, TileLayer } from 'react-leaflet';

export let pollingPlaceRequests = {
  mapResults: function(columns, rows){
    let result = {};
    columns.forEach(function(val, ind, arr){
      result[val] = rows[0][ind];
    });
    return result;
  },
  voter: function(house, zip, dob, apikey){
    //takes a house number, zip code, and date of birth as a Date object or in the format: 'MM/DD/YYYY'
    var p = new Promise(function(resolve, reject){
      var now = new Date();
      if (typeof dob.getMonth == 'function') {
        if (dob.getMonth() > 12 || dob.getMonth() <= 0) reject('Month was out of range: ' + dob.getMonth());
        if (dob.getDate() >= 32) reject('Date was out of range: ' + dob.getDate());
        if (dob.getFullYear() > now.getFullYear()-16 || dob.getFullYear() < now.getFullYear()-120) reject('Year was out of range: ' + dob.getFullYear());
        
        let month = dob.getMonth() <= 9 ? '' + 0 + '' + dob.getMonth() : '' + dob.getMonth();
        let date = '' + dob.getDate();
        let year = '' + dob.getFullYear();
        dob = `${month}/${date}/${year}`;
      }
      var mapResults = pollingPlaceRequests.mapResults;
      
      request
      .get('https://www.googleapis.com/fusiontables/v1/query')
      .query({"sql": `SELECT  PollName, VBM, BT, ID, MailDate, ReturnDate FROM 13cxU5gasxEIZpLSAQqI3l_B_guMrmbHomOFDqq-E where ZipCode='${zip}' and HouseNum='${house}' and BirthDate='${dob}'`})
      .query({key: apikey})
      .end(function(err, res){
        if (err || !res.ok) {
          reject(err);
        } else {
          if (res.body.columns && res.body.rows && res.body.rows.length == 1) {
            let result = mapResults(res.body.columns, res.body.rows);
            resolve(result);
          } else if (res.body.rows && res.body.rows.length > 1) {
            reject('Too many results');
          } else reject(res.body);
        }
      });
    });
    return p;
  },
  place: function(pollid, apikey){
    apikey = apikey || this.props.fusionkey;
    var p = new Promise(function(resolve, reject){
      // poll address from pollname ID
      var mapResults = pollingPlaceRequests.mapResults;
      
      request
      .get('https://www.googleapis.com/fusiontables/v1/query')
      .query({sql: `SELECT  'Polling place', Address, City, Zip, Lat, Long FROM 1Sr6r-0V5njdzHp9cGNbqS5qljj9qJH7mn__HsHbL WHERE ID='${pollid}'`})
      .query({key: apikey})
      .end(function(err, res){
        if (err || !res.ok) {
          reject(err);
        } else {
          if (res.body.columns && res.body.rows && res.body.rows.length == 1) {
            resolve(mapResults(res.body.columns, res.body.rows));
          } else if (res.body.rows && res.body.rows.length > 1) {
            reject('Too many polling places were found with id: ' + pollid);
          } else reject(res.body);
        }
      });
    });
    return p;
  },
  geocode: function(location, mapboxkey, approxLat, approxLong){
    var p = new Promise(function(resolve, reject){
      mapboxkey = mapboxkey || this.props.mapboxkey;
      approxLat = approxLat || this.props.approxLat;
      approxLong = approxLong || this.props.approxLong;
      // mapbox geocode
      request
      .get(`https://api.mapbox.com/geocoding/v5/mapbox.places/${encodeURI(location)}.json`)
      .query({access_token: "pk.eyJ1IjoiYnJvb2tzbiIsImEiOiJjaWpkbmkzMDEwMDh3dGdra2Y0OHYwbjViIn0.gqY3_NGpI96FuDQ7csaOUw"})
      .query({proximity: `${approxLong},${approxLat}`})
      .end(function(err, res){
        if (err || !res.ok) {
          reject(err);
        } else {
          resolve(JSON.parse(res.text).features[0]);
        }
      });
    });
    return p;
  }
};

export default class PollingPlaceForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      house: null,
      zip: null,
      dob: null,
      place: null,
      address: null,
      latitude: null,
      longitude: null,
    };
  }
  render() {
    var caption = this.state.caption || this.props.caption;
    var addressLink = this.state.address ? <a href={'http://maps.google.com/?q='+encodeURI(this.state.address)}>➶</a> : null;
    //var map = (this.state.latitude && this.state.longitude) ? <h1>Map!!</h1> : null;
    if (!this.state.latitude || !this.state.longitude) var map = null;
    else {
      var map = (
        <div style={this.props.styles.root}>
          <Map center={[this.state.latitude, this.state.longitude]} zoom={15} style={this.props.styles.map}>
            <TileLayer
              url='http://{s}.tile.osm.org/{z}/{x}/{y}.png'
              attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
            />
          <Marker position={[this.state.latitude, this.state.longitude]}>
              <Popup>
                <span>{this.state.place}</span>
              </Popup>
            </Marker>
          </Map>
        </div>
      );
    }
    return (
      <div className="polling-place-form row">
        <div className="medium-12 columns">
          <h1>Polling Place Form</h1>
          <p>
            <span>house num: <input type="text" name="house" onChange={this.handleHouseChange.bind(this)}></input></span><br />
            <span>zip: <input type="text" name="zip" onChange={this.handleZipChange.bind(this)}></input></span><br />
            <span>date of birth: <input type="text" name="dob" onChange={this.handleDobChange.bind(this)}></input></span><br />
            <span><input type="submit" value="Submit" onClick={this.handleSubmit.bind(this)}></input></span><br />
          </p>
          <p>{caption} {addressLink}</p>
          {map}
        </div>
      </div>
    );
  }
  handleSubmit(event) {
    pollingPlaceRequests.voter(this.state.house, this.state.zip, this.state.dob, this.props.fusionkey)
    .then(function(data){
      if (data.MailDate && data.MailDate != '') {
        this.setState({caption: `Your absentee ballot was mailed to this address on ${data.MailDate}. You may still vote at your polling place on election day.`, mailDate: data.MailDate})
      }
      return data.PollName;
    }.bind(this))
    .then(pollingPlaceRequests.place.bind(this))
    .then(function(place){
      this.setState({place: place['Polling place'], address: `${place.Address} ${place.City}, ${this.props.stateAbbr} ${place.Zip}`, latitude: place.Lat, longitude: place.Long});
      var caption = '';
      if (this.state.mailDate && this.state.mailDate != '') caption += `Your absentee ballot was mailed to this address on ${this.state.mailDate}. You may still vote at your polling place on election day. `;
      caption += `Your polling place is located at ${place['Polling place']}.`;
      this.setState({caption: caption});
      if (!place.Lat || !place.Long) {
        pollingPlaceRequests.geocode(this.state.address, this.props.mapboxkey, this.props.approxLat, this.props.approxLong)
        .then(function(result){
          this.setState({latitude: result.center[1], longitude: result.center[0]});
        }.bind(this));
      }
    }.bind(this))
    .catch(function(err){
      this.setState({caption: `There was an error finding your polling place: ${err}`});
      this.setState({place: null, address: null});
    }.bind(this));
  }
  handleHouseChange(e) {
    this.setState({house: e.target.value});
  }
  handleZipChange(e) {
    this.setState({zip: e.target.value});
  }
  handleDobChange(e) {
    this.setState({dob: e.target.value});
  }
}

PollingPlaceForm.defaultProps = {
  fusionkey: 'AIzaSyBXp2otyudYdGVmWC498IsawNeStFRuJBk', //read-only access
  mapboxkey: 'pk.eyJ1IjoiYnJvb2tzbiIsImEiOiJjaWpkbmkzMDEwMDh3dGdra2Y0OHYwbjViIn0.gqY3_NGpI96FuDQ7csaOUw', //geocoding API
  caption: 'Enter hour house number, zip code, and date of birth to find your polling place.',
  stateAbbr: 'CA',
  approxLat: '38.5789777', //geocoding bias
  approxLong: '-121.4829292', //geocoding bias
  styles: {
    root: {
      height: '10em'
    },
    map: {
      height: '100%'
    }
  }
};
