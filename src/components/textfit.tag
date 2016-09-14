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
      console.log('ran');
    });

    // TODO: implement textfit function with binary search
    function textfit (parent, element) {
      let fontSize = minFontSize;
      while (!isOverflowing(parent) && fontSize <= maxFontSize) {
        fontSize++;
        element.style.fontSize = fontSize;
      }
      element.style.fontSize = fontSize - 1;
    }

    function isOverflowing (element) {
      return (element.scrollWidth > element.offsetWidth || element.scrollHeight > element.offsetHeight);
    }

    function guid() {
      function s4() {
        return Math.floor((1 + Math.random()) * 0x10000)
          .toString(16)
          .substring(1);
      }
      return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
    }
  </script>
</textfit>
