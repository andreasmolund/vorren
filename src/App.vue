<template>
  <TideTable :waterlevels="waterlevels"/>
  <!-- <img alt="Vue logo" src="./assets/logo.png"> -->
</template>

<script>
import TideTable from './components/TideTable.vue'
import axios from "axios"
import { addDays, format } from "date-fns"
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
      const daysToPredict = 7
      let from = format(new Date(), "yyyy-MM-dd")
      let to = format(addDays(new Date(), daysToPredict), "yyyy-MM-dd")
      let url = 'http://api.sehavniva.no/tideapi.php?tide_request=locationdata&lat=68.7782192&lon=17.1796206&datatype=TAB&lang=nb&place=Har&dst=1&fromtime=' + from + 'T00:00&totime=' + to + 'T23:59&interval=10&flag=high'
      axios
        .get(url)
        .then(response => {
          var self = this;
          var allWaterlevels = []
          parseString(response.data, {explicitArray: false} , function (err, result) {
            allWaterlevels = result.tide.locationdata.data.waterlevel
          })

          var waterlevelsPerDay = []
          let waterlevelsCurrentDay = []
          var lastDay = "1970-01-01"
          var currentDay = "1970-01-01"
          var i;
          for (i = 0; i < allWaterlevels.length; i++) {

            currentDay = format(new Date(allWaterlevels[i]["$"].time), "yyyy-MM-dd")
            
            if (i == 0) {
              lastDay = currentDay
            }

            if (currentDay === lastDay) {
              waterlevelsCurrentDay.push(allWaterlevels[i])
            } else {
              waterlevelsPerDay.push({day: currentDay, levels: waterlevelsCurrentDay})
              waterlevelsCurrentDay = []
              waterlevelsCurrentDay.push(allWaterlevels[i])
              lastDay = currentDay
            }

          }

          waterlevelsPerDay.push({day: currentDay, levels: waterlevelsCurrentDay})

          self.waterlevels = waterlevelsPerDay
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
  font-size: 1rem;
}

@import './assets/styles/bootstrap-5.0.1-dist/css/bootstrap.min.css';
</style>
