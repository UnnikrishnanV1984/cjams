import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ProviderProfileComponent } from './provider-profile.component';
import { ProviderProfileRoutingModule } from './provider-profile-routing.module';
import { MatRadioModule } from '@angular/material/radio';
import { FormMaterialModule } from '../../../../@core/form-material.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker/dist/datetimepicker.module';
import { QuillModule } from 'ngx-quill';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';
import { ProviderAddressModule } from '../../../../shared/shared-components/provider-address/provider-address.module';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';
import { MatCardModule } from '@angular/material/card';

@NgModule({
  imports: [
    CommonModule,
    ProviderProfileRoutingModule,
    MatRadioModule,
    FormMaterialModule,
    // A2Edatetimepicker,
    QuillModule.forRoot(),
    PaginationModule,
    SharedComponentsModule,
    ProviderAddressModule,
    MatFormFieldModule,
    MatSelectModule,
    MatCardModule,
  ],
  declarations: [
    ProviderProfileComponent
  ],
  providers: []
})
export class ProviderProfileModule { }
