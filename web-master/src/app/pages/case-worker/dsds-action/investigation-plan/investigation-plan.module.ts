import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatCardModule } from '@angular/material/card';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatTooltipModule } from '@angular/material/tooltip';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../shared/modules/control-messages/control-messages.module';
import {
  InvestigationPlanExceptionTaskComponent,
} from './investigation-plan-result/investigation-plan-exception-task/investigation-plan-exception-task.component';
import {
  InvestigationPlanGoalDetailComponent,
} from './investigation-plan-result/investigation-plan-goal-detail/investigation-plan-goal-detail.component';
import {
  InvestigationPlanPolicyTaskComponent,
} from './investigation-plan-result/investigation-plan-policy-task/investigation-plan-policy-task.component';
import { InvestigationPlanResultComponent } from './investigation-plan-result/investigation-plan-result.component';
import { InvestigationPlanRoutingModule } from './investigation-plan-routing.module';
import {
  InvestigationPlanActivityComponent,
} from './investigation-plan-search/investigation-plan-activity/investigation-plan-activity.component';
import {
  InvestigationPlanDeleteActivityComponent,
} from './investigation-plan-search/investigation-plan-delete-activity/investigation-plan-delete-activity.component';
import { InvestigationPlanSearchComponent } from './investigation-plan-search/investigation-plan-search.component';
import {
  InvestigationPlanSuggestedTaskComponent,
} from './investigation-plan-search/investigation-plan-suggested-task/investigation-plan-suggested-task.component';
import {
  InvestigationPlanTaskComponent,
} from './investigation-plan-search/investigation-plan-task/investigation-plan-task.component';
import { InvestigationPlanComponent } from './investigation-plan.component';
import { InvestigationResolverService } from './investigation-plan-resolver.service';

@NgModule({
    imports: [
        PaginationModule,
        CommonModule,
        // A2Edatetimepicker,
        MatFormFieldModule,
        MatDatepickerModule,
        MatInputModule,
        MatSelectModule,
        MatRadioModule,
        MatCardModule,
        InvestigationPlanRoutingModule,
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        NgSelectModule,
        SharedPipesModule,
        SharedDirectivesModule,
        MatTooltipModule
    ],
    declarations: [
        InvestigationPlanComponent,
        InvestigationPlanSearchComponent,
        InvestigationPlanActivityComponent,
        InvestigationPlanSuggestedTaskComponent,
        InvestigationPlanDeleteActivityComponent,
        InvestigationPlanTaskComponent,
        InvestigationPlanResultComponent,
        InvestigationPlanPolicyTaskComponent,
        InvestigationPlanExceptionTaskComponent,
        InvestigationPlanGoalDetailComponent
    ],
    providers: [InvestigationResolverService]
})
export class InvestigationPlanModule {}
