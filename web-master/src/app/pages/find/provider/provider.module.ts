import { ProviderComponent } from './provider.component';
import { ProviderRoutingModule } from './provider-routing.module';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DmhProviderComponent } from './dmh-provider/dmh-provider.component';
import { DsdsProviderComponent } from './dsds-provider/dsds-provider.component';
import { HomeHealthHospitalComponent } from './home-health-hospital/home-health-hospital.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { BsDatepickerModule } from 'ngx-bootstrap/datepicker';
import { ProviderFilterCriteriaComponent } from './provider-filter-criteria/provider-filter-criteria.component';
import { DsdsProviderViewComponent } from './dsds-provider/dsds-provider-view/dsds-provider-view.component';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule, ProviderRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    BsDatepickerModule,
    NgSelectModule,
    SharedPipesModule
  ],
  declarations: [ProviderComponent, DmhProviderComponent, DsdsProviderComponent, ProviderFilterCriteriaComponent,
    HomeHealthHospitalComponent,
    DsdsProviderViewComponent]
})
export class ProviderModule { }
