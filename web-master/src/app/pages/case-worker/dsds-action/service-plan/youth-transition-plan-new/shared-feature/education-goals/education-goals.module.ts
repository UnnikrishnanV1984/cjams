import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';

import { EducationGoalsComponent } from './education-goals.component';
import { FormMaterialModule } from '../../../../../../../@core/form-material.module';

@NgModule({
  imports: [
    CommonModule,
    FormMaterialModule,
    NgxMaskDirective,
    NgxMaskPipe
    ],
    providers:[provideNgxMask()],
  declarations: [EducationGoalsComponent],
  exports: [EducationGoalsComponent]
})
export class EducationGoalsModule { }
