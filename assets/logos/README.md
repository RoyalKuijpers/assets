# Logos

This directory contains logo variations for the Kuijpers brand.

## Structure

- `primary/` - Primary logo variations
- `secondary/` - Secondary logo variations
- `monochrome/` - Monochrome versions

## Usage

Logos can be referenced in your projects:

```javascript
const { getLogoPath } = require('@royalkuijpers/kuijpers-assets');
const logoPath = getLogoPath('primary/logo.svg');
```
