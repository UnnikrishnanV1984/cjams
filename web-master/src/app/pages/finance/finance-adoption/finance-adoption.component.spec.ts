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
import { FinanceAdoptionSearchFiltersComponent } from './finance-adoption-search-filters/finance-adoption-search-filters.component';
import { FinanceAdoptionSearchResultComponent } from './finance-adoption-search-result/finance-adoption-search-result.component';
import { FinanceAdoptionComponent } from './finance-adoption.component';

describe('FinanceAdoptionComponent', () => {
    let component: FinanceAdoptionComponent;
    let fixture: ComponentFixture<FinanceAdoptionComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [FinanceAdoptionComponent, FinanceAdoptionSearchFiltersComponent, FinanceAdoptionSearchResultComponent],
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
        fixture = TestBed.createComponent(FinanceAdoptionComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
