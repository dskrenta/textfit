<textfit>
  <span id={randID}>
    <yield />
  </span>

  <script>
    this.randID = guid();
    const maxFontSize = parseInt(opts.maxfontsize);
    const minFontSize = parseInt(opts.minfontsize);
    const self = this;

    this.on('mount', () => {
      const parent = document.getElementById(self.randID).parentNode.parentNode;
      const element = document.getElementById(self.randID);
      textfit(parent, element);
    });

    function textfit (parent, element) {
      let low = minFontSize;
      let high = maxFontSize;
      let mid = 0;
      while (low <= high) {
        mid = parseInt((low + high) / 2, 10);
        element.style.fontSize = mid;
        isOverflowing(parent) ? high = mid - 1 : low = mid + 1;
      }
      element.style.fontSize = mid - 1;
    }

    function isOverflowing (parent) {
      return (parent.offsetHeight < parent.scrollHeight || parent.offsetWidth < parent.scrollWidth);
    }

    function guid () {
      function s4 () {
        return Math.floor((1 + Math.random()) * 0x10000)
          .toString(16)
          .substring(1);
      }
      return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
    }
  </script>
</textfit>
