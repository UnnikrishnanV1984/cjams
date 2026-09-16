import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ServiceCaseManagementComponent } from './service-case-management.component';
import { MatCardModule } from '@angular/material/card';
import { MatGridListModule } from '@angular/material/grid-list';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule,
    FormMaterialModule,
    MatCardModule,
    MatGridListModule,
    SharedPipesModule
  ],
  declarations: [ServiceCaseManagementComponent],
  exports:[ServiceCaseManagementComponent]
})
export class ServiceCaseManagementModule { }
