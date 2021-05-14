export default {
    mounted() {
        setTimeout(() => {
          let c = this.el.parentElement.parentElement.classList;
          c.remove('animate__animated')
          c.add('animate__animated')
          c.add('animate__fadeOutRight')
          setTimeout(() => {
            this.pushEvent('lv:clear-flash', this.el.attributes['phx-value-key'].value)
          }, 2000);
        }, 5000);
      }
}
 