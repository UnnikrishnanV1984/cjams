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
import { FinancePlacementSearchFiltersComponent } from './finance-placement-search-filters/finance-placement-search-filters.component';
import { FinancePlacementSearchResultComponent } from './finance-placement-search-result/finance-placement-search-result.component';
import { FinancePlacementComponent } from './finance-placement.component';

describe('FinancePlacementComponent', () => {
    let component: FinancePlacementComponent;
    let fixture: ComponentFixture<FinancePlacementComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [FinancePlacementComponent, FinancePlacementSearchFiltersComponent, FinancePlacementSearchResultComponent],
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
        fixture = TestBed.createComponent(FinancePlacementComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
