import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ShortTermGoalsComponent } from './short-term-goals.component';
import { FormMaterialModule } from '../../../../../../../@core/form-material.module';

@NgModule({
  imports: [
    CommonModule,
    FormMaterialModule
  ],
  declarations: [ShortTermGoalsComponent],
  exports: [ShortTermGoalsComponent]
})
export class ShortTermGoalsModule { }
