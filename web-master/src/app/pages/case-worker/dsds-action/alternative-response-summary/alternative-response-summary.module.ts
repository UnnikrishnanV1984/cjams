import { NgModule } from '@angular/core';
import { QuillModule } from 'ngx-quill';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { CommonModule } from '@angular/common';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import { NgSelectModule } from '@ng-select/ng-select';
import { AlternativeResponseSummaryComponent } from './alternative-response-summary.component';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { MatTooltipModule } from '@angular/material/tooltip';

// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { AlternativeResponseSummaryRoutingModule } from './alternative-response-summary-routing.module';
import { InvestigationFindingsModule } from '../investigation-findings/investigation-findings.module';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { AlternativeResponseSummaryResolverService } from './alternative-response-summary-resolver-service';
import { GlobalPopupModule } from '../../../../shared/shared-components/global-popup/global-popup.module';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';


@NgModule({
  imports: [
    CommonModule,
    MatCardModule,
    MatCheckboxModule,
    MatDatepickerModule,
    MatExpansionModule,
    MatFormFieldModule,
    MatInputModule,
    MatListModule,
    MatNativeDateModule,
    MatRadioModule,
    QuillModule.forRoot(),
    MatSelectModule,
    MatTableModule,
    MatTabsModule,
    MatTooltipModule,
    // A2Edatetimepicker,
    AlternativeResponseSummaryRoutingModule,
    ControlMessagesModule,
    InvestigationFindingsModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    NgSelectModule,
    SharedDirectivesModule,
    // SharedComponentsModule,
    GlobalPopupModule
  ],
  declarations: [AlternativeResponseSummaryComponent],
  providers: [AlternativeResponseSummaryResolverService]
})
export class AlternativeResponseSummaryModule { }
