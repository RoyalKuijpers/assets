const path = require('path');

/**
 * Kuijpers Assets Library
 * Provides programmatic access to brand assets
 */

const ASSETS_DIR = path.join(__dirname, 'assets');

/**
 * Get the absolute path to an asset
 * @param {string} assetPath - Relative path to the asset within the assets directory
 * @returns {string} Absolute path to the asset
 */
function getAssetPath(assetPath) {
  return path.join(ASSETS_DIR, assetPath);
}

/**
 * Get the absolute path to an image asset
 * @param {string} imagePath - Relative path to the image within assets/images
 * @returns {string} Absolute path to the image
 */
function getImagePath(imagePath) {
  return path.join(ASSETS_DIR, 'images', imagePath);
}

/**
 * Get the absolute path to an icon asset
 * @param {string} iconPath - Relative path to the icon within assets/icons
 * @returns {string} Absolute path to the icon
 */
function getIconPath(iconPath) {
  return path.join(ASSETS_DIR, 'icons', iconPath);
}

/**
 * Get the absolute path to a logo asset
 * @param {string} logoPath - Relative path to the logo within assets/logos
 * @returns {string} Absolute path to the logo
 */
function getLogoPath(logoPath) {
  return path.join(ASSETS_DIR, 'logos', logoPath);
}

/**
 * Get the absolute path to a font asset
 * @param {string} fontPath - Relative path to the font within assets/fonts
 * @returns {string} Absolute path to the font
 */
function getFontPath(fontPath) {
  return path.join(ASSETS_DIR, 'fonts', fontPath);
}

/**
 * Get the absolute path to a style asset
 * @param {string} stylePath - Relative path to the style within assets/styles
 * @returns {string} Absolute path to the style
 */
function getStylePath(stylePath) {
  return path.join(ASSETS_DIR, 'styles', stylePath);
}

/**
 * Get the absolute path to the assets root directory
 * @returns {string} Absolute path to the assets directory
 */
function getAssetsDir() {
  return ASSETS_DIR;
}

module.exports = {
  getAssetPath,
  getImagePath,
  getIconPath,
  getLogoPath,
  getFontPath,
  getStylePath,
  getAssetsDir,
  // Export individual asset type directories
  ASSETS_DIR,
  IMAGES_DIR: path.join(ASSETS_DIR, 'images'),
  ICONS_DIR: path.join(ASSETS_DIR, 'icons'),
  LOGOS_DIR: path.join(ASSETS_DIR, 'logos'),
  FONTS_DIR: path.join(ASSETS_DIR, 'fonts'),
  STYLES_DIR: path.join(ASSETS_DIR, 'styles'),
};
