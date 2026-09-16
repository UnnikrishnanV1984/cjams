import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AdminSharedModule } from '../../_shared/admin-shared.module';
import { EntityConfigurationRoutingModule } from './entity-configuration-routing.module';
import { EntityConfigurationComponent } from './entity-configuration.component';
import {
  ContactAddressTypeComponent, ContactPhoneTypeComponent, EntityAddressTypeComponent,
  EntityPhoneTypeComponent, EntityRoleTypeComponent, EntityTypeComponent
} from '.';
@NgModule({
  imports: [
    CommonModule,
    EntityConfigurationRoutingModule,
    AdminSharedModule
  ],
  declarations: [EntityAddressTypeComponent,
     EntityPhoneTypeComponent, EntityTypeComponent,
      EntityRoleTypeComponent, ContactAddressTypeComponent, ContactPhoneTypeComponent, EntityConfigurationComponent]
})
export class EntityConfigurationModule { }
