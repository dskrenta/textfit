<textfit>
  <span>
    <yield />
  </span>

  <script>
    const maxFontSize = parseInt(opts.maxfontsize);
    const minFontSize = parseInt(opts.minfontsize);
    const fontface = opts.fontface;
    const self = this;

    this.on('mount', () => {
      const parent = self.root.parentNode;
      const element = self.root.children[0];
      const canvas = createCanvas(parent);
      textfitWithCanvas(element, canvas);
      // textfit(parent, element);
    });

    function textfitWithCanvas (element, canvas, fontface) {
      const text = element.innerText;
      const ctx = canvas.getContext('2d');
      let low = minFontSize;
      let high = maxFontSize;
      let mid = 0;
      while (low <= high) {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        mid = parseInt((low + high) / 2, 10);
        ctx.font = `${mid}px ${fontface}`;
        ctx.fillText(text, 0, 100);
        if (ctx.measureText(text).width > canvas.width) {
          high = mid - 1;
        } else {
          low = mid + 1;
        }
      }
      console.log(mid - 1);
      element.style.fontSize = mid - 1;
    }

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

    function createCanvas (parent) {
      const canvas = document.createElement('canvas');
      // canvas.style.display = 'none';
      canvas.width = parent.offsetWidth;
      canvas.height = parent.offsetHeight;
      document.body.appendChild(canvas);
      return canvas;
    }
  </script>
</textfit>
