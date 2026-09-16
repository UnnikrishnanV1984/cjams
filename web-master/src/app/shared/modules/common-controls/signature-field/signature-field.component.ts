import { Component, ViewChild, forwardRef, AfterViewInit, Input, SimpleChange  } from '@angular/core';
import { NG_VALUE_ACCESSOR, ControlValueAccessor } from '@angular/forms';
import { SignaturePadComponent } from '@almothafar/angular-signature-pad';

/*
  Generated class for the SignatureField component.
  See https://angular.io/docs/ts/latest/api/core/ComponentMetadata-class.html
  for more info on Angular 2 Components.
*/

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'signature-field',
    host: {
        class: 'signature-field'
    },
    templateUrl: 'signature-field.component.html',
    providers: [
        {
            provide: NG_VALUE_ACCESSOR,
            useExisting: forwardRef(() => SignatureFieldComponent),
            multi: true,
        },
    ],
    standalone: false
})
export class SignatureFieldComponent implements ControlValueAccessor, AfterViewInit {
  @ViewChild(SignaturePadComponent) public signaturePad!: SignaturePadComponent;
  @Input() public clearSignature: boolean = false;

  //  public options: Object = {};

  public options: any = {
    'minWidth': 2,
    'canvasWidth': 315,
    'canvasHeight': 140,
    'style':"touch-action: none;"
  };

  public _signature: any = null;

  public propagateChange: Function | null = null;

  get signature(): any {
    return this._signature;
  }

  set signature(value: any) {
    this._signature = value;
    if (this.propagateChange !== null) {
        this.propagateChange(this.signature);
    }
  }

  public writeValue(value: any): void {
    if (!value) {
      return;
    }
    this._signature = value;
    this.signaturePad?.fromDataURL(this.signature);
  }

  public registerOnChange(fn: any): void {
    this.propagateChange = fn;
  }

  public registerOnTouched(): void {
    // no-op
  }

  public ngAfterViewInit(): void {
    if(this.signaturePad) {
      this.signaturePad.clear();
    }
  }

  ngOnChanges(changes: any) {
    if(changes['clearSignature']) {
      if(changes['clearSignature'].currentValue && this.signaturePad) {
          this.signaturePad.clear();
          this.signature = '';
      }
    }
}

  public drawBegin(): void {
  // No content to add or call
  // No operation needed here
  }

  public drawComplete(): void {
    this.signature = this.signaturePad.toDataURL('image/png', 0.5);
  }

  public clear(): void {
    this.signaturePad.clear();
    this.signature = '';
  }

}
