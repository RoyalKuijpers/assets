# Icons

This directory contains icon assets for the Kuijpers brand.

## Structure

- `svg/` - SVG vector icons
- `png/` - PNG raster icons (various sizes)

## Usage

Icons can be referenced in your projects:

```javascript
const { getIconPath } = require('@royalkuijpers/kuijpers-assets');
const iconPath = getIconPath('svg/home.svg');
```
