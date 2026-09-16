import { NgModule } from '@angular/core';
import { Routes } from '@angular/router';
import { ServiceCaseManagementComponent } from './service-case-management.component';
import { CommonModule } from '@angular/common';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatCardModule } from '@angular/material/card';


const routes: Routes = [{
  path: '',
  component: ServiceCaseManagementComponent
}];

@NgModule({
  imports: [
    CommonModule,
    FormMaterialModule,
    MatCardModule,
    MatGridListModule
  ],
  exports: [],
  declarations: [],
  providers: []
})
export class ServiceCaseManagementRoutingModule { }
