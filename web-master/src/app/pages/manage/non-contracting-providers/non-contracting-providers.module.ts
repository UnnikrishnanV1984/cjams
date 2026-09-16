import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NonContractingProvidersRoutingModule } from './non-contracting-providers-routing.module';
import { NonContractingProvidersComponent } from './non-contracting-providers.component';
import { AddEditNonContractingProvidersComponent } from './add-edit-non-contracting-providers/add-edit-non-contracting-providers.component';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule,
    NonContractingProvidersRoutingModule,
    NgSelectModule,
    SharedPipesModule
  ],
  declarations: [NonContractingProvidersComponent, AddEditNonContractingProvidersComponent],
  exports: [AddEditNonContractingProvidersComponent]
})
export class NonContractingProvidersModule { }
