import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormMaterialModule } from '../../../../@core/form-material.module';

import { AddressDetailsRoutingModule } from './address-details-routing.module';
import { AddressDetailsComponent } from './address-details.component';
import { AddAddressComponent } from './add-address/add-address.component';
import { ListAddressComponent } from './list-address/list-address.component';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { AddressDetailsService } from './address-details.service';
import { ShareFeaturesModule } from '../share-features/share-features.module';

@NgModule({ declarations: [AddressDetailsComponent, AddAddressComponent, ListAddressComponent], imports: [CommonModule,
        AddressDetailsRoutingModule,
        FormMaterialModule,
        ShareFeaturesModule], providers: [AddressDetailsService, provideHttpClient(withInterceptorsFromDi())] })
export class AddressDetailsModule { }
