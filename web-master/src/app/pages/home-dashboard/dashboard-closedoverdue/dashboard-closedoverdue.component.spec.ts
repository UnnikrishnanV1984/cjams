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
import { DashboardClosedoverdueComponent } from './dashboard-closedoverdue.component';

describe('DashboardClosedoverdueComponent', () => {
    let component: DashboardClosedoverdueComponent;
    let fixture: ComponentFixture<DashboardClosedoverdueComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    // providers: [{ provide: HighchartsStatic, useFactory: highchartfactory }],
    declarations: [DashboardClosedoverdueComponent],
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
        fixture = TestBed.createComponent(DashboardClosedoverdueComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
