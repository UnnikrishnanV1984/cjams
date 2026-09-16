import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FinanceAdjustmentRoutingModule } from './finance-adjustment-routing.module';
import { FinanceAdjustmentComponent } from './finance-adjustment.component';
import { PlacementAdjustmentComponent } from './placement-adjustment/placement-adjustment.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { NgSelectModule } from '@ng-select/ng-select';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
// import { MatRippleModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatTooltipModule } from '@angular/material/tooltip';
import { AdjustmentSearchComponent } from './adjustment-search/adjustment-search.component';
import { AdjustmentResultComponent } from './adjustment-result/adjustment-result.component';
import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';

@NgModule({
  imports: [
    CommonModule,
    FinanceAdjustmentRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    // A2Edatetimepicker,
    NgSelectModule,
    MatDatepickerModule,
    MatInputModule,
    MatCheckboxModule,
    MatSelectModule,
    MatFormFieldModule,
    // MatRippleModule,
    MatButtonModule,
    MatRadioModule,
    MatTooltipModule,
     SharedDirectivesModule,
    SharedPipesModule,
    NgxMaskDirective,
    NgxMaskPipe
  ],
  providers:[provideNgxMask()],
  declarations: [FinanceAdjustmentComponent, PlacementAdjustmentComponent, AdjustmentSearchComponent, AdjustmentResultComponent]
})
export class FinanceAdjustmentModule { }
