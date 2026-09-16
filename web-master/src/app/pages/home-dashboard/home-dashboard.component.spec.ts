import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { GridsterModule } from 'angular-gridster2';
// import { ChartModule } from 'angular2-highcharts';
// import { HighchartsStatic } from 'angular2-highcharts/dist/HighchartsService';
import { HighchartsChartModule } from 'highcharts-angular';
import { DynamicModule } from 'ng-dynamic-component';
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../@core/core.module';
import { ControlMessagesModule } from '../../shared/modules/control-messages/control-messages.module';
import { DashboardRestorewidgetsComponent } from './dashboard-restorewidgets/dashboard-restorewidgets.component';
import { HomeDashboardRoutingModule } from './home-dashboard-routing.module';
import { HomeDashboardComponent } from './home-dashboard.component';
import { highchartfactory } from './home-dashboard.module';
import { DashboardTeamstatisticsComponent } from './dashboard-teamstatistics/dashboard-teamstatistics.component';
import { DashboardMyclosedcasescountComponent } from './dashboard-myclosedcasescount/dashboard-myclosedcasescount.component';
import { DashboardTeamperformanceComponent } from './dashboard-teamperformance/dashboard-teamperformance.component';
import { DashboardMyteamoverdueComponent } from './dashboard-myteamoverdue/dashboard-myteamoverdue.component';
import { DashboardClosedoverdueComponent } from './dashboard-closedoverdue/dashboard-closedoverdue.component';
import { DashboardMydsdsactionsComponent } from './dashboard-mydsdsactions/dashboard-mydsdsactions.component';
import { DashboardMytodoComponent } from './dashboard-mytodo/dashboard-mytodo.component';
import { DashboardMytasksComponent } from './dashboard-mytasks/dashboard-mytasks.component';

describe('HomeDashboardComponent', () => {
    let component: HomeDashboardComponent;
    let fixture: ComponentFixture<HomeDashboardComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    // providers: [{ provide: HighchartsStatic, useFactory: highchartfactory }],
    declarations: [HomeDashboardComponent, DashboardRestorewidgetsComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        ReactiveFormsModule,
        ControlMessagesModule,
        NgSelectModule,
        A2Edatetimepicker,
        RouterModule,
        GridsterModule,
        // ChartModule,
        HomeDashboardRoutingModule,
        FormsModule,
        PaginationModule,
        DynamicModule.withComponents([
            HomeDashboardComponent,
            DashboardTeamstatisticsComponent,
            DashboardMyclosedcasescountComponent,
            DashboardRestorewidgetsComponent,
            DashboardTeamperformanceComponent,
            DashboardMyteamoverdueComponent,
            DashboardClosedoverdueComponent,
            DashboardMydsdsactionsComponent,
            DashboardMytodoComponent,
            DashboardMytasksComponent
        ]),
        GridsterModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(HomeDashboardComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
