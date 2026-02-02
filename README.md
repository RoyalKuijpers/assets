# Kuijpers Assets Library

A comprehensive collection of brand assets, design resources, and visual elements for the Kuijpers organization.

## 📦 Installation

```bash
npm install @royalkuijpers/kuijpers-assets
```

## 🎯 What's Included

This library provides organized access to:

- **Images** - Brand imagery, banners, backgrounds, and product photos
- **Icons** - SVG and PNG icons for UI elements
- **Logos** - Official logo variations and lockups
- **Fonts** - Brand typography and font files
- **Styles** - CSS variables, color palettes, and design tokens

## 🚀 Usage

### Using in Node.js

```javascript
const assets = require('@royalkuijpers/kuijpers-assets');

// Get paths to specific assets
const logoPath = assets.getLogoPath('primary/logo.svg');
const iconPath = assets.getIconPath('svg/home.svg');
const imagePath = assets.getImagePath('banners/hero.jpg');

// Access asset directories
console.log(assets.ASSETS_DIR);    // Root assets directory
console.log(assets.IMAGES_DIR);    // Images directory
console.log(assets.ICONS_DIR);     // Icons directory
console.log(assets.LOGOS_DIR);     // Logos directory
console.log(assets.FONTS_DIR);     // Fonts directory
console.log(assets.STYLES_DIR);    // Styles directory
```

### Using Design Tokens

The library includes design tokens in multiple formats:

**CSS Custom Properties:**
```css
@import '@royalkuijpers/kuijpers-assets/assets/styles/colors.css';
@import '@royalkuijpers/kuijpers-assets/assets/styles/variables.css';

.button {
  background-color: var(--kuijpers-primary);
  padding: var(--kuijpers-spacing-md);
  border-radius: var(--kuijpers-radius-lg);
}
```

**JSON Tokens:**
```javascript
const tokens = require('@royalkuijpers/kuijpers-assets/assets/styles/tokens.json');

console.log(tokens.colors.primary.base); // #0066CC
console.log(tokens.spacing.md);          // 16px
```

## 📁 Directory Structure

```
kuijpers-assets/
├── assets/
│   ├── images/          # Image assets
│   ├── icons/           # Icon assets (SVG, PNG)
│   ├── logos/           # Logo variations
│   ├── fonts/           # Font files
│   └── styles/          # CSS and design tokens
│       ├── colors.css
│       ├── variables.css
│       └── tokens.json
├── index.js             # Main entry point
├── package.json
├── LICENSE
└── README.md
```

## 🎨 Design System

### Colors

The library provides a comprehensive color palette:

- **Primary:** `#0066CC` (with light and dark variants)
- **Secondary:** `#FF6B00` (with light and dark variants)
- **Neutral:** White, black, and 9 shades of gray
- **Semantic:** Success, warning, error, and info colors

### Typography

- Font families for base and monospace text
- Font sizes from xs (12px) to 4xl (36px)
- Font weights: normal, medium, semibold, bold
- Line heights: tight, normal, relaxed

### Spacing

Consistent spacing scale from xs (4px) to 3xl (64px)

### Other Design Elements

- Border radius values
- Box shadows
- Transition timings
- Z-index layers

## 🤝 Contributing

We welcome contributions! Please see our [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Adding New Assets

1. Place assets in the appropriate directory under `assets/`
2. Update the relevant README in the asset directory
3. Update this main README if adding a new asset category
4. Submit a pull request

## 📄 License

MIT © Royal Kuijpers

## 🔗 Links

- [GitHub Repository](https://github.com/RoyalKuijpers/kuijpers-assets)
- [Report Issues](https://github.com/RoyalKuijpers/kuijpers-assets/issues)
- [NPM Package](https://www.npmjs.com/package/@royalkuijpers/kuijpers-assets)
