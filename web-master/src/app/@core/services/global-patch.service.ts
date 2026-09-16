import { Injectable, OnDestroy, Renderer2, RendererFactory2 } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class GlobalPatchService implements OnDestroy {
  private renderer: Renderer2;
  private events: { type: string; handler: (event: Event) => void }[] = [];

  constructor(rendererFactory: RendererFactory2) {
    this.renderer = rendererFactory.createRenderer(null, null);

    this.events = [
      { type: 'hide.bs.modal', handler: this.onHide },
      { type: 'hide.bs.offcanvas', handler: this.onHide },
      { type: 'show.bs.modal', handler: this.onShow },
      { type: 'show.bs.offcanvas', handler: this.onShow },
    ];

    // Attach all event listeners
    this.events.forEach(({ type, handler }) => document.addEventListener(type, handler));
  }

  // Hide handler: blur focused elements and apply inert
  private onHide = (event: Event) => {
    const container = event.target as HTMLElement;
    const activeEl = document.activeElement as HTMLElement;

    if (container.contains(activeEl)) {
      activeEl.blur();
    }

    this.renderer.setAttribute(container, 'inert', '');
  };

  // Show handler: remove inert 
  private onShow = (event: Event) => {
    const container = event.target as HTMLElement;
    this.renderer.removeAttribute(container, 'inert');
  };

  ngOnDestroy(): void {
    // Clean up event listeners
    this.events.forEach(({ type, handler }) => document.removeEventListener(type, handler));
  }
}
