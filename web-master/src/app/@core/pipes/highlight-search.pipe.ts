import { Pipe, PipeTransform } from '@angular/core';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';
/**
 * @description
 * This pipe is used to find and highlight a search term within a string of text.
 * It performs a case-insensitive search for all occurrences of the search term
 * and wraps each match in a <span> tag with the class 'search-highlight'.
 *
 * It returns a 'SafeHtml' object that can be safely rendered using [innerHTML]
 * in a component's template, preventing XSS vulnerabilities.
 *
 * @usage
 * <td [innerHTML]="cellValue | highlightSearch: searchTerm"></td>
 *
 * @param {string} value The original text to search within.
 * @param {string} searchTerm The term to highlight within the value.
 * @returns {SafeHtml} The text with all matches highlighted, wrapped in a SafeHtml object.
 */
@Pipe({
  name: 'highlightSearch'
})
export class HighlightSearchPipe implements PipeTransform {

  constructor(private sanitizer: DomSanitizer) {}

transform(value: string | null | undefined, searchTerm: string | null | undefined): SafeHtml {
  // If there is no value, return empty safe HTML.
    if (!value) {
      return this.sanitizer.bypassSecurityTrustHtml('');
    }

     // Escape the result text before showing it in HTML.
    // This prevents any script or HTML from running.
    const escapedValue = this.escapeHtml(value);

      // If search text is empty, return the escaped result text.
    if (!searchTerm || searchTerm.trim() === '') {
      return this.sanitizer.bypassSecurityTrustHtml(escapedValue);
    }

    // Escape HTML in the search term so it matches the escaped value
    const htmlEscapedSearch = this.escapeHtml(searchTerm.trim());

    // Escape regex special characters
    const regexSafeSearch = this.escapeRegExp(htmlEscapedSearch);

    // Create a regular expression for a case-insensitive global search
    const regex = new RegExp(regexSafeSearch, 'gi');
    
    // Replace the matched term with a styled span
    const highlightedValue = escapedValue.replace(regex, (match) => `<span class="search-highlight">${match}</span>`);

    // Trust only after escaping all user-controlled values
    return this.sanitizer.bypassSecurityTrustHtml(highlightedValue);
  }

  private escapeHtml(value: string): string {
      // Convert HTML characters into plain text.
    return value
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;');
  }

  private escapeRegExp(value: string): string {
    // Escape regex special characters so search text is treated normally.
    return value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  }
}