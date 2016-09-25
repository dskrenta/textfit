<textfit>
  <span>
    <yield />
  </span>

  <script>
    const maxFontSize = parseInt(opts.maxfontsize);
    const minFontSize = parseInt(opts.minfontsize);
    const multiline = opts.multiline;
    const self = this;

    this.on('mount', () => {
      const parent = self.root.parentNode;
      const element = self.root.children[0];
      const canvas = createCanvas(parent);
      const fontfamily = getStyle(parent, 'font-family');
      textfit(element, canvas, fontfamily);
      removeElement(canvas);
    });

    function textfit (element, canvas, fontface) {
      const text = element.innerText;
      const ctx = canvas.getContext('2d');
      let low = minFontSize;
      let high = maxFontSize;
      let mid = 0;

      while (low <= high) {
        mid = parseInt((low + high) / 2, 10);
        const lineHeight = mid * 1.14;
        ctx.font = `${mid}px ${fontface}`;

        if (multiline) {
          const count = wordWrap(ctx, text, 0, canvas.height, canvas.width, lineHeight);
          const textHeight = lineHeight * count;
          if (textHeight > canvas.height) {
            high = mid - 1;
          } else {
            low = mid + 1;
          }
        } else {
          ctx.fillText(text, 0, canvas.height);
          if (ctx.measureText(text).width > canvas.width) {
            high = mid - 1;
          } else {
            low = mid + 1;
          }
        }
      }

      element.style.fontSize = mid - 1;
    }

    function wordWrap (ctx, text, x, y, maxWidth, lineHeight) {
      const words = text.split(' ');
      let line = '';
      let count = 1;

      for(let i = 0; i < words.length; i++) {
        const testLine = `${line + words[i]} `;
        const metrics = ctx.measureText(testLine);
        const testWidth = metrics.width;

        if (testWidth > maxWidth && i > 0) {
          ctx.fillText(line, x, y);
          line = `${words[i]} `;
          y += lineHeight;
          count++;
        } else {
          line = testLine;
        }
      }

      ctx.fillText(line, x, y);
      return count;
    }

    function createCanvas (parent) {
      const canvas = document.createElement('canvas');
      canvas.style.display = 'none';
      canvas.width = parent.offsetWidth;
      canvas.height = parent.offsetHeight;
      document.body.appendChild(canvas);
      return canvas;
    }

    function getStyle (element, property) {
      return window.getComputedStyle(element, null).getPropertyValue(property);
    }

    function removeElement (element) {
      element.remove();
    }
  </script>
</textfit>
