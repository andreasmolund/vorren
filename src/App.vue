<template>
  <TideTable :waterlevels="waterlevels"/>
  <!-- <img alt="Vue logo" src="./assets/logo.png"> -->
</template>

<script>
import TideTable from './components/TideTable.vue'
import axios from "axios"
var parseString = require('xml2js').parseString;

export default {
  name: 'App',
  components: {
    TideTable,
  },
  data() {
    return {
      waterlevels: [],
    }
  },
  methods: {
    async fetchWaterlevels() {
      axios
        .get('http://api.sehavniva.no/tideapi.php?tide_request=locationdata&lat=68.7782192&lon=17.1796206&datatype=TAB&lang=nb&place=Har&dst=1&fromtime=2021-06-06T00:00&totime=2021-06-30T23:59&interval=10&flag=high')
        .then(response => {
          var self = this;
          parseString(response.data, {explicitArray: false} , function (err, result) {
            self.waterlevels = result.tide.locationdata.data.waterlevel
          })
        })
    }
  },
  mounted() {
    this.fetchWaterlevels()
  },
}
</script>

<style>
html {
  font-size: 1.2rem;
}

@import './assets/styles/bootstrap-5.0.1-dist/css/bootstrap.min.css';
</style>
