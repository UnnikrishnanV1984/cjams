import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PlacementMenuComponent } from './placement-menu.component';
import { PlacementMenuRoutingModule } from './placement-menu-routing.module';

@NgModule({
  imports: [
    CommonModule,
    PlacementMenuRoutingModule
  ],
  declarations: [PlacementMenuComponent]
})
export class PlacementMenuModule { }
