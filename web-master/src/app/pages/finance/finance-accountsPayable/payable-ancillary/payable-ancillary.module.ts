import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PayableAncillaryRoutingModule } from './payable-ancillary-routing.module';
import { PayableAncillaryComponent } from './payable-ancillary.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatRippleModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { ProviderInfoPopupModule } from '../../provider-info-popup/provider-info-popup.module';

@NgModule({
  imports: [
    CommonModule,
    PayableAncillaryRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    // A2Edatetimepicker,
    NgSelectModule,
    SharedPipesModule,
    MatDatepickerModule,
    MatInputModule,
    MatCheckboxModule,
    MatSelectModule,
    MatFormFieldModule,
    MatRippleModule,
    MatButtonModule,
    MatRadioModule,
    ProviderInfoPopupModule,
    SharedPipesModule
  ],
  declarations: [PayableAncillaryComponent]
})
export class PayableAncillaryModule { }
