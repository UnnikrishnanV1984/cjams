import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SignatureFieldComponent } from './signature-field.component';
import { AngularSignaturePadModule } from '@almothafar/angular-signature-pad';

@NgModule({
  declarations: [SignatureFieldComponent],
  imports: [CommonModule,AngularSignaturePadModule],
  exports: [SignatureFieldComponent]
})
export class SignatureFieldModule {}
