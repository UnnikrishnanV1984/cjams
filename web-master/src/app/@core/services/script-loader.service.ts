import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class ScriptLoaderService {
  private loadedScripts: { [url: string]: boolean } = {};

  loadScript(url: string): Promise<void> {
    return new Promise((resolve, reject) => {
      if (this.loadedScripts[url]) {
        resolve();
        return;
      }

      const script = document.createElement('script');
      script.src = url;
      script.onload = () => {
        this.loadedScripts[url] = true;
        resolve();
      };
      script.onerror = () => reject(`Failed to load script ${url}`);
      document.body.appendChild(script);
    });
  }

  async loadScripts(urls: string[]): Promise<void[]> {
    return Promise.all(urls.map(url => this.loadScript(url)));
  }
}
