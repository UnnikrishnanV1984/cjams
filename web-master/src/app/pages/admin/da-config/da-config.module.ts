import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { DaConfigRoutingModule } from './da-config-routing.module';
import { DaConfigComponent } from './da-config.component';
import { CatalogueComponent } from './shared/catalogue/catalogue.component';

@NgModule({
  imports: [
    CommonModule,
    DaConfigRoutingModule, ReactiveFormsModule,  FormsModule
  ],
  declarations: [DaConfigComponent, CatalogueComponent],
  exports: [DaConfigComponent]
})
export class DaConfigModule { }
