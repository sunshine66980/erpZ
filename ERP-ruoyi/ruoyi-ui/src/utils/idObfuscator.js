/**
 * Simple ID obfuscation utility to hide sequential IDs
 * Uses a reversible encoding with a simple key
 */

const KEY = 0x5f7a3c9d; // Random key for encoding
const BASE = 36; // Use base36 for shorter strings

/**
 * Encode a numeric ID to a string
 * @param {number} id - The numeric ID to encode
 * @returns {string} - Encoded string
 */
export function encodeId(id) {
  if (!Number.isInteger(id) || id < 1) {
    throw new Error('ID must be a positive integer');
  }
  
  // Simple reversible encoding: XOR with key and convert to base36
  const encoded = (id ^ KEY) >>> 0; // Ensure positive
  return encoded.toString(BASE);
}

/**
 * Decode an encoded string back to numeric ID
 * @param {string} encoded - The encoded string
 * @returns {number} - Original numeric ID
 */
export function decodeId(encoded) {
  if (!encoded || typeof encoded !== 'string') {
    throw new Error('Encoded ID must be a non-empty string');
  }
  
  try {
    const decoded = parseInt(encoded, BASE);
    if (isNaN(decoded)) {
      throw new Error('Invalid encoded ID format');
    }
    
    return (decoded ^ KEY) >>> 0;
  } catch (error) {
    throw new Error('Failed to decode ID');
  }
}

/**
 * Validate if an encoded ID is valid
 * @param {string} encoded - The encoded string to validate
 * @returns {boolean} - True if valid
 */
export function isValidEncodedId(encoded) {
  try {
    decodeId(encoded);
    return true;
  } catch {
    return false;
  }
}