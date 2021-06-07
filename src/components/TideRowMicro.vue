<template>
  <tr v-if="isHighTide()">
    <td scope="row">{{ formatDate(waterlevelInstance["$"].time) }}</td>
    <td>{{ formatTime(waterlevelInstance["$"].time) }}</td>
    <td>{{ waterlevelInstance["$"].value }}</td>
  </tr>
  
</template>

<script>
import { format } from "date-fns"

export default {
  props: {
    waterlevelInstance: {
      type: Object,
      required: true,
    },
    highTide: Boolean,
  },
  methods: {
    formatDate(strDate) {
      return format(new Date(strDate), "MMMM do")
    },
    formatTime(strDate) {
      return format(new Date(strDate), "HH:mm")
    },
    isHighTide() {
      return this.waterlevelInstance["$"].flag == "high"
    }
  }
}
</script>