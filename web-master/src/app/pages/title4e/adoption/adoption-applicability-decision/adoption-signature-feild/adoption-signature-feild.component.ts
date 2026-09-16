import { Component, ViewChild, forwardRef, AfterViewInit } from '@angular/core';
import { NG_VALUE_ACCESSOR, ControlValueAccessor } from '@angular/forms';
import { SignaturePadComponent } from '@almothafar/angular-signature-pad';
import { DataStoreService, CommonHttpService } from '../../../../../@core/services';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'adoption-signature-feild',
    templateUrl: './adoption-signature-feild.component.html',
    providers: [
        {
            provide: NG_VALUE_ACCESSOR,
            useExisting: forwardRef(() => AdoptionSignatureFeildComponent),
            multi: true,
        },
    ],
    standalone: false
})
export class AdoptionSignatureFeildComponent implements   ControlValueAccessor, AfterViewInit {

  @ViewChild(SignaturePadComponent) public signaturePad!: SignaturePadComponent;
  // @ViewChild('signaturepad') signaturepadContainer: ElementRef;
  isSignPresent: boolean=false;
  public options: any = {
    'minWidth': 5,
    'canvasWidth': 580,
    'canvasHeight': 140
  };

  public _signature: any = null;

  public propagateChange!: Function ;

  constructor(private _dataStoreService: DataStoreService, private _commonHttpService: CommonHttpService,) {
    this._dataStoreService.currentStore.subscribe(store => {
      this.isSignPresent = store['isSignPresent'];
      if (this.isSignPresent) {
        this.signaturePad.off();
      }
    });
  }

  get signature(): any {
    return this._signature;
  }

  set signature(value: any) {
    this._signature = value;
    this.propagateChange(this.signature);
  }

  public writeValue(value: any): void {
    if (!value) {
      return;
    }
    this._signature = value;
    if(this.signaturePad){
      this.signaturePad.fromDataURL(this.signature);
    }
  }

  public registerOnChange(fn: any): void {
    this.propagateChange = fn;
  }

  public registerOnTouched(): void {
    // no-op
  }

  public ngAfterViewInit(): void {
    this.signaturePad.clear();
    // this.signaturePad.set('canvasWidth', (this.signaturepadContainer.nativeElement as HTMLElement).offsetWidth);
    // this.signaturePad.set('canvasHeight', (this.signaturepadContainer.nativeElement as HTMLElement).offsetHeight);
  }

  public drawBegin(): void {
    // No operation needed here
  }

  public drawComplete(): void {
    this.signature = this.signaturePad.toDataURL('image/png', 0.5);
    this._commonHttpService.updateSignature(this.signaturePad.toDataURL());
  }

  public clear(): void {
    this.signaturePad.clear();
    this.signature = '';
  }

}
