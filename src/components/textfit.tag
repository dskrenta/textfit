<textfit>
  <span id="textfit">
    <yield />
  </span>

  <style scoped>
    span {

    }
  </style>

  <script>
    const maxFontSize = parseInt(opts.maxfontsize);
    const minFontSize = parseInt(opts.minfontsize);

    this.on('mount', () => {
      const parent = document.getElementById('textfit').parentNode.parentNode;
      const textfit = document.getElementById('textfit');
      let realFontSize = minFontSize;
      while (!isOverflowing(parent) && realFontSize <= maxFontSize) {
        realFontSize++;
        textfit.style.fontSize = realFontSize;
      }
      textfit.style.fontSize = realFontSize - 1;
    });

    function isOverflowing (element) {
      return (element.scrollWidth > element.offsetWidth || element.scrollHeight > element.offsetHeight);
    }
  </script>
</textfit>
