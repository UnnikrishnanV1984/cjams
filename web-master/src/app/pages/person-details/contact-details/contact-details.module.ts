import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ContactDetailsRoutingModule } from './contact-details-routing.module';
import { ContactDetailsComponent } from './contact-details.component';
import { ReactiveFormsModule } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';

@NgModule({
  imports: [
    CommonModule,
    ContactDetailsRoutingModule,
    ReactiveFormsModule,
    MatSelectModule,
    MatFormFieldModule,
    MatRadioModule,
    MatInputModule,
    NgxMaskDirective,
    NgxMaskPipe
    ],
    providers:[provideNgxMask()],
  declarations: [ContactDetailsComponent]
})
export class ContactDetailsModule { }
