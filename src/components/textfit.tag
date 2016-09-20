<textfit>
  <span id={randID}>
    <yield />
  </span>

  <script>
    const maxFontSize = parseInt(opts.maxfontsize);
    const minFontSize = parseInt(opts.minfontsize);
    const self = this;

    this.on('mount', () => {
      const parent = self.root.parentNode;
      const element = self.root.children[0];
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
  </script>
</textfit>
