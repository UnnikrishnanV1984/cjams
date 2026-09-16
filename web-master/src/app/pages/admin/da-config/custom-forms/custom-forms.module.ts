import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';


import { CustomFormsRoutingModule } from './custom-forms-routing.module';
import { CustomFormsComponent } from './custom-forms.component';

@NgModule({
  imports: [
    CommonModule,
    CustomFormsRoutingModule,
    NgSelectModule,
    SharedPipesModule
  ],
  declarations: [CustomFormsComponent]
})
export class CustomFormsModule { }
