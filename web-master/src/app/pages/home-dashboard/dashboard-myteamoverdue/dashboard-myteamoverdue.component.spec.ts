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
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../@core/core.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { highchartfactory } from '../home-dashboard.module';
import { DashboardMyteamoverdueComponent } from './dashboard-myteamoverdue.component';

describe('DashboardMyteamoverdueComponent', () => {
    let component: DashboardMyteamoverdueComponent;
    let fixture: ComponentFixture<DashboardMyteamoverdueComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    // providers: [{ provide: HighchartsStatic, useFactory: highchartfactory }],
    declarations: [DashboardMyteamoverdueComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        A2Edatetimepicker,
        RouterModule,
        GridsterModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(DashboardMyteamoverdueComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
