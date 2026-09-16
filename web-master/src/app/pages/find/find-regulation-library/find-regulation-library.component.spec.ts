import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../@core/core.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { FindRegulationLibraryComponent } from './find-regulation-library.component';
import { RegulationLibraryResultComponent } from './regulation-library-result/regulation-library-result.component';
import { RegulationLibrarySearchComponent } from './regulation-library-search/regulation-library-search.component';
import { RegulationLibraryViewComponent } from './regulation-library-view/regulation-library-view.component';

describe('FindRegulationLibraryComponent', () => {
    let component: FindRegulationLibraryComponent;
    let fixture: ComponentFixture<FindRegulationLibraryComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [FindRegulationLibraryComponent, RegulationLibrarySearchComponent, RegulationLibraryResultComponent, RegulationLibraryViewComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(FindRegulationLibraryComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
