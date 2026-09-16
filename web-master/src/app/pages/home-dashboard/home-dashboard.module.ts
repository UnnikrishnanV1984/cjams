import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
// import { MatTableModule } from '@angular/material/table';
// import { MatTooltipModule } from '@angular/material/tooltip';
import { GridsterModule } from 'angular-gridster2';
// import { HighchartsChartModule } from 'highcharts-angular';
import { DynamicModule } from 'ng-dynamic-component';
// import { PaginationModule } from 'ngx-bootstrap/pagination';
// import { MatSortModule } from '@angular/material/sort';
// import { DashboardClosedoverdueComponent } from './dashboard-closedoverdue/dashboard-closedoverdue.component';
// import { DashboardMyappApprovalsComponent } from './dashboard-myappapprovals/dashboard-myappapprovals.component';
// import { DashboardMyappAppealsComponent } from './dashboard-myappeals/dashboard-myappeals.component';
// import { DashboardMyappsComponent } from './dashboard-myapps/dashboard-myapps.component';
// import { DashboardMyarComponent } from './dashboard-myar/dashboard-myar.component';
// import { DashboardMyclosedcasescountComponent } from './dashboard-myclosedcasescount/dashboard-myclosedcasescount.component';
// import { DashboardMydsdsactionsComponent } from './dashboard-mydsdsactions/dashboard-mydsdsactions.component';
// import { DashboardMyirComponent } from './dashboard-myir/dashboard-myir.component';
// import { DashboardMytasksComponent } from './dashboard-mytasks/dashboard-mytasks.component';
// import { DashboardMyteamoverdueComponent } from './dashboard-myteamoverdue/dashboard-myteamoverdue.component';
// import { DashboardMytodoComponent } from './dashboard-mytodo/dashboard-mytodo.component';
// import { DashboardRestorewidgetsComponent } from './dashboard-restorewidgets/dashboard-restorewidgets.component';
// import { DashboardTeamperformanceComponent } from './dashboard-teamperformance/dashboard-teamperformance.component';
// import { DashboardTeamstatisticsComponent } from './dashboard-teamstatistics/dashboard-teamstatistics.component';
import { HomeDashboardRoutingModule } from './home-dashboard-routing.module';
import { HomeDashboardComponent } from './home-dashboard.component';
// import { DashboardChecklistNotificationComponent } from './dashboard-checklist-notification/dashboard-checklist-notification.component';
// import { DashboardMynoncpsComponent } from './dashboard-mynoncps/dashboard-mynoncps.component';
// import { DashboardMyservicecaseComponent } from './dashboard-myservicecase/dashboard-myservicecase.component';
// import { PersonInformationComponent } from './person-information/person-information.component';
// import { DashboardMyadoptioncaseComponent } from './dashboard-myadoptioncase/dashboard-myadoptioncase.component';
// import { DashboardLDSSMyinquiriesComponent } from './dashboard-ldss-myinquiries/dashboard-ldss-myinquiries.component';
// import { DashboardMyrejectedclosedappComponent } from './dashboard-myrejectedclosedapp/dashboard-myrejectedclosedapp.component';
// import { NgxPaginationModule } from 'ngx-pagination';
import { HomeDashboardService } from './home-dashboard.service';
// import { DashboardDataResolverService } from './home-dashboard-resolver.service';
import { ExcelService } from './excel.service';
// import { DashboardMyappealcaseComponent } from './dashboard-myappealcase/dashboard-myappealcase.component';
// import { DashboardAdoptionticklerComponent } from './dashboard-adoptiontickler/dashboard-adoptiontickler.component';
// import { DashboardGapticklerComponent } from './dashboard-gaptickler/dashboard-gaptickler.component';
// import { CustomTableActionsModule } from '../../shared/shared-components/custom-table-actions/custom-table-actions.module';
// import { CustomTableModule } from '../../shared/shared-components/custom-table/custom-table.module';
import { GuardModule } from '../../@core/guard.module';
// import { MatFormFieldModule } from '@angular/material/form-field';
// import { MatInputModule } from '@angular/material/input';
// import { MatRadioModule } from '@angular/material/radio';
// import { MatSelectModule } from '@angular/material/select';
// import { MatButtonModule } from '@angular/material/button';

// export function highchartfactory() {
//     return require('highcharts');
// }

@NgModule({
    imports: [
        CommonModule,
        HomeDashboardRoutingModule,
        FormsModule,
        ReactiveFormsModule,
        // PaginationModule,
        // MatTooltipModule,
        // NgxPaginationModule,
        // MatTableModule,
        GridsterModule,
        DynamicModule,
        // HighchartsChartModule,
        // CustomTableActionsModule,
        // CustomTableModule,
        GuardModule,
        // MatFormFieldModule,
        // MatInputModule,
        // MatRadioModule,
        // MatSelectModule,
        // MatButtonModule, MatSortModule
    ],
    providers: [
        // { provide: HighchartsStatic, useFactory: highchartfactory }, // add as factory to your providers
        HomeDashboardService
        // , DashboardDataResolverService
        ,ExcelService
    ],
    

    declarations: [
        HomeDashboardComponent,
        // DashboardTeamstatisticsComponent,
        // DashboardMyclosedcasescountComponent,
        // DashboardRestorewidgetsComponent,
        // DashboardTeamperformanceComponent,
        // DashboardMyteamoverdueComponent,
        // DashboardClosedoverdueComponent,
        // DashboardMydsdsactionsComponent,
        // DashboardMytodoComponent,
        // DashboardMytasksComponent,
        // DashboardMyarComponent,
        // DashboardMyirComponent,
        // DashboardMyappsComponent,
        // DashboardMyrejectedclosedappComponent,
        // DashboardMyappApprovalsComponent,
        // DashboardMyappAppealsComponent,
        // DashboardChecklistNotificationComponent,
        // DashboardMynoncpsComponent,
        // DashboardMyservicecaseComponent,
        // PersonInformationComponent,
        // DashboardMyadoptioncaseComponent,
        // DashboardLDSSMyinquiriesComponent,
        // DashboardMyappealcaseComponent,
        // DashboardAdoptionticklerComponent,
        // DashboardGapticklerComponent
    ],
    exports: [
        // PersonInformationComponent
    ]
})
export class HomeDashboardModule {}