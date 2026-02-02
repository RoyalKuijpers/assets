# Contributing to Kuijpers Assets Library

Thank you for your interest in contributing to the Kuijpers Assets Library! This document provides guidelines for contributing.

## How to Contribute

### Adding New Assets

1. **Fork the repository** and create a new branch for your contribution
2. **Add your assets** to the appropriate directory:
   - Images → `assets/images/`
   - Icons → `assets/icons/`
   - Logos → `assets/logos/`
   - Fonts → `assets/fonts/`
   - Styles → `assets/styles/`

3. **Follow naming conventions:**
   - Use lowercase and hyphens (kebab-case): `my-asset.svg`
   - Be descriptive: `hero-banner-homepage.jpg` not `img1.jpg`
   - Include dimensions for raster images: `icon-32x32.png`

4. **Organize properly:**
   - Group related assets in subdirectories
   - Update or create README files in subdirectories
   - Keep file sizes reasonable (optimize images)

5. **Update documentation:**
   - Add your asset to the relevant README
   - Update examples if needed
   - Update the main README if adding new categories

### Asset Guidelines

#### Images
- Use appropriate formats (JPG for photos, PNG for transparency, SVG for vectors)
- Optimize file sizes (use tools like ImageOptim, TinyPNG)
- Include multiple sizes if needed (thumbnails, full-size)
- Maximum recommended size: 2MB per image

#### Icons
- Prefer SVG format for scalability
- Include PNG versions in common sizes (16x16, 24x24, 32x32, 48x48)
- Use a consistent viewBox for SVGs (e.g., `0 0 24 24`)
- Remove unnecessary metadata from SVG files

#### Logos
- Provide multiple formats (SVG, PNG)
- Include variations (full color, monochrome, white)
- Maintain clear space requirements
- Document minimum size requirements

#### Fonts
- Only include fonts with proper licensing
- Include multiple formats (WOFF2, WOFF, TTF)
- Provide font weights and styles used in the brand
- Include license information

#### Styles
- Follow existing CSS conventions
- Use CSS custom properties (CSS variables)
- Keep JSON tokens synchronized with CSS
- Document any new tokens added

### Code Contributions

If you're improving the library code (index.js, build scripts, etc.):

1. **Write clean, documented code**
2. **Follow existing code style**
3. **Add tests if applicable**
4. **Update documentation**

### Pull Request Process

1. **Create a descriptive pull request**
   - Explain what assets you're adding/changing
   - Include screenshots for visual assets
   - Reference any related issues

2. **Ensure your PR:**
   - Follows all guidelines above
   - Includes updated documentation
   - Has no merge conflicts
   - Passes any automated checks

3. **Review process:**
   - Maintainers will review your contribution
   - Address any feedback or requested changes
   - Once approved, your PR will be merged

## Asset Quality Standards

### All Assets Must:
- ✅ Be properly licensed for use
- ✅ Follow brand guidelines
- ✅ Be optimized for file size
- ✅ Be properly named and organized
- ✅ Include documentation

### Assets Must NOT:
- ❌ Contain copyrighted material without permission
- ❌ Include personal or sensitive information
- ❌ Be excessively large in file size
- ❌ Have generic or unclear names

## Questions?

If you have questions about contributing, please:
- Open an issue for discussion
- Contact the maintainers
- Check existing issues and PRs for examples

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

Thank you for helping improve the Kuijpers Assets Library! 🎉
