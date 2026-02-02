# Images

This directory contains image assets for the Kuijpers brand.

## Structure

- `banners/` - Banner images and hero images
- `backgrounds/` - Background images
- `products/` - Product photography
- `misc/` - Other miscellaneous images

## Usage

Images can be referenced in your projects:

```javascript
const { getImagePath } = require('@royalkuijpers/kuijpers-assets');
const bannerPath = getImagePath('banners/hero.jpg');
```
