import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BeaconRoutingModule } from './beacon-routing.module';
import { BeaconComponent } from './beacon.component';
import { BeaconViewDialogComponent } from './beacon-view-dialog/beacon-view-dialog.component';
import { FormMaterialModule } from '../../@core/form-material.module';
import { CustomTableModule } from '../../shared/shared-components/custom-table/custom-table.module';
// import { SharedComponentsModule } from '../../shared/shared-components/shared-components.module';
 
@NgModule({
  declarations: [
    BeaconComponent,
    BeaconViewDialogComponent,
  ],
  imports: [
    CommonModule,
    BeaconRoutingModule,
    FormMaterialModule,
    // SharedComponentsModule,
    CustomTableModule
  ]
})
export class BeaconModule { }
