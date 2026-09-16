import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonDatePickerComponent } from './common-date-picker/common-date-picker.component';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { AppMaskDateDirective } from './app-mask-date.directive';

// import { AngularSignaturePadModule } from '@almothafar/angular-signature-pad';
import { SignatureFieldModule } from './signature-field/signature-field.module';
import { CurrencyInputComponent } from './currency-input/currency-input.component';
import {provideNgxMask, NgxMaskDirective} from 'ngx-mask';

@NgModule({
  imports: [
    CommonModule,
    FormsModule, ReactiveFormsModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatFormFieldModule,
    MatInputModule,
    // AngularSignaturePadModule,
    NgxMaskDirective,
    SignatureFieldModule

  ],
  providers:[provideNgxMask()],
  declarations: [CommonDatePickerComponent, AppMaskDateDirective,  CurrencyInputComponent],
  exports: [CommonDatePickerComponent, AppMaskDateDirective, CurrencyInputComponent]
})
export class CommonControlsModule { }
