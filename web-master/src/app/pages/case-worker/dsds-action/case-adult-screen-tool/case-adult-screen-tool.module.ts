import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CaseAdultScreenToolRoutingModule } from './case-adult-screen-tool-routing.module';
import { CaseAdultScreenToolComponent } from './case-adult-screen-tool.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';

@NgModule({
  imports: [
    CommonModule,
    CaseAdultScreenToolRoutingModule,
    FormMaterialModule,
    NgxMaskDirective,
    NgxMaskPipe
    
  ],
  providers:[provideNgxMask()],
  declarations: [
    CaseAdultScreenToolComponent
  ]
})
export class CaseAdultScreenToolModule { }
