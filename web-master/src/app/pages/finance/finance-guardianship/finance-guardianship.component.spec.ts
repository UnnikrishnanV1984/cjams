import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../@core/core.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { FinanceGuardianshipSearchFiltersComponent } from './finance-guardianship-search-filters/finance-guardianship-search-filters.component';
import { FinanceGuardianshipSearchResultComponent } from './finance-guardianship-search-result/finance-guardianship-search-result.component';
import { FinanceGuardianshipComponent } from './finance-guardianship.component';

describe('FinanceGuardianshipComponent', () => {
    let component: FinanceGuardianshipComponent;
    let fixture: ComponentFixture<FinanceGuardianshipComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [FinanceGuardianshipComponent, FinanceGuardianshipSearchFiltersComponent, FinanceGuardianshipSearchResultComponent],
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        A2Edatetimepicker,
        SharedPipesModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(FinanceGuardianshipComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
