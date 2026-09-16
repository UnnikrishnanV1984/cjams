import { Injectable } from '@angular/core';
import { ScriptLoaderService } from './script-loader.service';

@Injectable({ providedIn: 'root' })
export class ScriptInitializerService {
  private loaded = false;

    private heavyScripts = [
        "assets/js/jquery-ui.js",
        "assets/js/jquery.scrolling-tabs.js",
        "assets/js/formio.full.min.js",
        "assets/js/custom.js",
        "assets/js/feedback.js",
        "assets/js/bootstrap-datetimepicker.min.js"
    ];

  constructor(private scriptLoader: ScriptLoaderService) {}

  async init() {
    if (this.loaded) return;
    await this.scriptLoader.loadScripts(this.heavyScripts);
    this.loaded = true;
  }
}
