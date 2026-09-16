import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../@core/core.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { DmhProviderComponent } from './dmh-provider/dmh-provider.component';
import { DsdsProviderComponent } from './dsds-provider/dsds-provider.component';
import { HomeHealthHospitalComponent } from './home-health-hospital/home-health-hospital.component';
import { ProviderFilterCriteriaComponent } from './provider-filter-criteria/provider-filter-criteria.component';
import { ProviderComponent } from './provider.component';

describe('ProviderComponent', () => {
    let component: ProviderComponent;
    let fixture: ComponentFixture<ProviderComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [ProviderComponent, ProviderFilterCriteriaComponent, DmhProviderComponent, HomeHealthHospitalComponent, DsdsProviderComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        A2Edatetimepicker,
        RouterModule,
        SharedPipesModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(ProviderComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
