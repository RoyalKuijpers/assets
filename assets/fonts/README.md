# Fonts

This directory contains font files for the Kuijpers brand.

## Structure

Fonts are organized by typeface family.

## Usage

Fonts can be referenced in your projects:

```javascript
const { getFontPath } = require('@royalkuijpers/kuijpers-assets');
const fontPath = getFontPath('YourFont-Regular.woff2');
```

Or use in CSS:

```css
@font-face {
  font-family: 'YourFont';
  src: url('/path/to/assets/fonts/YourFont-Regular.woff2') format('woff2');
}
```
