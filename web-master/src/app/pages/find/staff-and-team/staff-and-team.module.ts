import { CommonModule, DatePipe } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { TreeModule } from '@ali-hm/angular-tree-component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { StaffAndTeamDetailsComponent } from './staff-and-team-details/staff-and-team-details.component';
import { StaffAndTeamResultComponent } from './staff-and-team-result/staff-and-team-result.component';
import { StaffAndTeamRoutingModule } from './staff-and-team-routing.module';
import { StaffAndTeamSearchComponent } from './staff-and-team-search/staff-and-team-search.component';
import { StaffAndTeamComponent } from './staff-and-team.component';
import { StaffAndTeamReasignComponent } from './staff-and-team-reasign/staff-and-team-reasign.component';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';

@NgModule({
    imports: [CommonModule, StaffAndTeamRoutingModule, MatDatepickerModule, MatFormFieldModule,  
        // A2Edatetimepicker, 
        FormsModule, ReactiveFormsModule, TreeModule, PaginationModule, NgSelectModule, SharedPipesModule],
    providers: [DatePipe],
    declarations: [StaffAndTeamComponent, StaffAndTeamSearchComponent, StaffAndTeamResultComponent, StaffAndTeamDetailsComponent, StaffAndTeamReasignComponent]
})
export class StaffAndTeamModule {}
