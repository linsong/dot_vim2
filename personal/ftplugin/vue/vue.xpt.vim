XPTemplate priority=personal

let s:f = g:XPTfuncs()

" use snippet 'varConst' to generate contant variables
" use snippet 'varFormat' to generate formatting variables
" use snippet 'varSpaces' to generate spacing variables


XPTinclude
    \ _common/common

" This snippet file enables vue files to use tabs for html, js and css. 
" It also includes some vue-specific html-like snippets, as well as 
" some general boilerplate code for vue.

" some html-like snippets

XPT slot
  <slot>`cursor^</slot>

XPT template
  <template>`cursor^</template>

XPT transition
  <transition>`cursor^</transition>

" The following snippets create more complex boilerplate code.

XPT vbase
<template>
  <div>

  </div>
</template>

<script>
  export default{
    `^
  }
</script>

<style scoped>

</style>

XPT vimport
import `Name^ from './components/`Name^.vue';

export default {
  components: {
    `Name^
  }
}
`cursor^

XPT vactions
actions: {
  `updateValue^({commit}, `payload^) {
    commit(`updateValue^, `payload^);
  }
}
'cursor^

" Add in js animation hooks
XPT vanim " template
<transition
  @before-enter="beforeEnter"
  @enter="enter"
  @after-enter="afterEnter"
  @enter-cancelled="enterCancelled"

  @before-Leave="beforeLeave"
  @leave="leave"
  @after-leave="afterLeave"
  @leave-cancelled="leaveCancelled"
  :css="false">

 </transition>
 `cursor^

XPT vanim " js implementation
methods: {
  beforeEnter(el) {
    console.log('beforeEnter');
  },
  enter(el, done) {
    console.log('enter');
    done();
  },
  afterEnter(el) {
    console.log('afterEnter');
  },
  enterCancelled(el, done) {
    console.log('enterCancelled');
  },
  beforeLeave(el) {
    console.log('beforeLeave');
  },
  leave(el, done) {
    console.log('leave');
    done();
  },
  afterLeave(el) {
    console.log('afterLeave');
  },
  leaveCancelled(el, done) {
    console.log('leaveCancelled');
  }
}
  `cursor^

XPT vcl
@click="`cursor^"

XPT vdata
data() {
  return {
    `key^: `value^
  };
}
`cursor^

XPT vfilter
filters: {
  `fnName^: function(`value^) {
    return;
  }
}
`cursor^

XPT vfor
<div v-for="`item^ in `items^" :key="`item^.id">
  {{ `item^`cursor^ }}
</div

XPT vgetters
getters: {
  `value^: state => {
    return state.`value^;
  }
}
`cursor^

XPT vimport
import `New^ from './components/`New^.vue';

XPT vkeep
<keep-alive>
  <component :is="`cursor^">
    <p>default</p>
  </component>
</keep-alive>

XPT vmixin
const `mixinName^ = {
  mounted() {
    console.log('hello from mixin!')
  },
}
const `Component^ = Vue.extend({
  mixins: [`mixinName^]
  `cursor^
})

XPT vmutations
mutations: {
  `updateValue^(state, `payload^) => {
    state.`value^ = `payload^;
    `cursor^
  }
}

XPT vprops wrap=default wraponly
`propName^: {
  type: `Number^,
  default: `default^
  `cursor^
},

XPT vprops
`propName^: {
  type: `Number^
  `cursor^
},

XPT vstore
import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export const store = new Vuex.Store({
  state: {
    `key^: `value^
    `cursor^
  }
});
