// src/app/services/html2canvas.service.ts
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class Html2CanvasService {

  private html2canvas: any = null;

  constructor() {}

  private async loadLibrary() {
    if (!this.html2canvas) {
      const module = await import('html2canvas');
      this.html2canvas = module.default;
    }
    return this.html2canvas;
  }

  async capture(element: any, options?: any): Promise<HTMLCanvasElement> {
    const html2canvas = await this.loadLibrary();
    return html2canvas(element,options);
  }
}
