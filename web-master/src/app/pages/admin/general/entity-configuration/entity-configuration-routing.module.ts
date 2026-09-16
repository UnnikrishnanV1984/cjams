import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import {
  ContactAddressTypeComponent,
  ContactPhoneTypeComponent,
  EntityAddressTypeComponent,
  EntityPhoneTypeComponent,
  EntityRoleTypeComponent,
  EntityTypeComponent,
} from '.';
import { EntityConfigurationComponent } from './entity-configuration.component';

const routes: Routes = [
    {
        path: '',
        component: EntityConfigurationComponent,
        children: [
            { path: 'contact-address-type', component: ContactAddressTypeComponent },
            { path: 'contact-phone-type', component: ContactPhoneTypeComponent },
            { path: 'entity-address-type', component: EntityAddressTypeComponent },
            { path: 'entity-phone-type', component: EntityPhoneTypeComponent },
            { path: 'entity-role-type', component: EntityRoleTypeComponent },
            { path: 'entity-type', component: EntityTypeComponent },
            { path: '', redirectTo: 'entity-address-type', pathMatch: 'full'}
        ]
    }
];
@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class EntityConfigurationRoutingModule {}
