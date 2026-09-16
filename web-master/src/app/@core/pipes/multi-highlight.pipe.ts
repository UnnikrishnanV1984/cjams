import { Pipe, PipeTransform } from '@angular/core';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';

export interface HighlightRequest {
  term: string | null | undefined;
  className: string;
}

@Pipe({
  name: 'multiHighlight'
})
export class MultiHighlightPipe implements PipeTransform {

  constructor(private sanitizer: DomSanitizer) {}

  transform(value: string | null | undefined, requests: HighlightRequest[]): SafeHtml {
    if (!value) {
      return '';
    }
    
    const allMatches: { start: number, end: number, className: string, originalIndex: number }[] = [];

    for (let i = 0; i < requests.length; i++) {
      const request = requests[i];
      if (!request.term || request.term.trim() === '') {
        continue;
      }
      const regex = new RegExp(this.escapeRegExp(request.term), 'gi');
      let match;
      while ((match = regex.exec(value)) !== null) {
        if (match[0].length === 0) {
          regex.lastIndex++;
          continue;
        }
        allMatches.push({
          start: match.index,
          end: match.index + match[0].length,
          className: request.className,
          originalIndex: i
        });
      }
    }

    if (allMatches.length === 0) {
      return this.sanitizer.bypassSecurityTrustHtml(this.escapeHtml(value));
    }

    // 1. Sort by start index (ascending).
    // 2. If start indices are the same, sort by original request index (descending),
    //    so a later request (higher index) comes first.
    allMatches.sort((a, b) => a.start - b.start || b.originalIndex - a.originalIndex);

    let highlightedHtml = '';
    let lastIndex = 0;

    for (const match of allMatches) {
      if (match.start < lastIndex) {
        continue;
      }

      highlightedHtml += this.escapeHtml(value.substring(lastIndex, match.start));
      highlightedHtml += `<span class="${match.className}">${this.escapeHtml(value.substring(match.start, match.end))}</span>`;
      lastIndex = match.end;
    }

    highlightedHtml += this.escapeHtml(value.substring(lastIndex));

    return this.sanitizer.bypassSecurityTrustHtml(highlightedHtml);
  }

  private escapeHtml(value: string): string {
    // Convert HTML characters into plain text so user-controlled data
    // (e.g. person names from the database) cannot inject markup/script.
    return value
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;');
  }

  private escapeRegExp(str: string): string {
    return str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  }
}