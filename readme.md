# Syntax Highlighter Iframe

Wrapping the Prism library in an iframe

## Usage

```html
<head>
  <title>My Website!</title> 
</head>
<body>
  <script>
    const frameUrl = new URL('https://cdn.davidalsh.com/syntax-highlight-iframe')
    const uniqueFrameIdentifier = (Math.random() * 100000).toFixed(0)
    const frame = document.createElement('iframe')
    const onload = new Promise(res => frame.onload = res)

    frame.src = frameUrl.href
    frame.style.border = 'none'
    frame.style.width = '100%'

    window.addEventListener('message', (ev) => {
      // Ignore messages from elsewhere
      if (ev.origin !== frameUrl.origin) return
      const { action, identifier, ...opts } = ev.data

      if (action === 'RESIZE') {
        const { height } = opts
        frame.style.height = height
      }
    })

    document.body.appendChild(frame)
    await onload

    frame.contentWindow.postMessage({
      action: 'CONFIG',
      // If you have multiple iframes on the page, use the 
      // identifier to match RESIZE events with your iframes
      identifier: uniqueFrameIdentifier,
      code: 'function foo() {}',
      // Look at Prism's website for more information on what
      // languages are available
      language: 'javascript'
    }, '*')
  </script>
</body>
```
