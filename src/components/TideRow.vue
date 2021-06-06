<template>
  <tr v-if="isHighTide()">
    <td scope="row">{{ formatDate(waterlevel["$"].time) }}</td>
    <td>{{ formatTime(waterlevel["$"].time) }}</td>
    <td>{{ waterlevel["$"].value }}</td>
  </tr>
  
</template>

<script>
import { format } from "date-fns"

export default {
  props: {
    waterlevel: {
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
      return this.waterlevel["$"].flag == "high"
    }
  },
  mounted() {
    console.log(this.waterlevel["$"].flag)
  },
}
</script>