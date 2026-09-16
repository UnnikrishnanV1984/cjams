import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { ProviderContractingRoutingModule } from './provider-contracting-routing.module';
import { ProviderContractingComponent } from './provider-contracting.component';

@NgModule({
  imports: [
    CommonModule,
    ProviderContractingRoutingModule
  ],
  declarations: [ProviderContractingComponent]
})
export class ProviderContractingModule { }
