<template>
  <TideRowMicro
      v-for="waterlevelInstance, index in extractLevels(waterlevel)" 
      :key="index" 
      :waterlevelInstance="waterlevelInstance" />  
</template>

<script>
import TideRowMicro from './TideRowMicro.vue'

export default {
  components: {
    TideRowMicro
  },
  props: {
    waterlevel: {
      type: Object,
      required: true,
    },
  },
  methods: {
    extractLevels(waterlevelObject) {
      return waterlevelObject.levels
    }
  },
}
</script>