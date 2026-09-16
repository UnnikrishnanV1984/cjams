import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../@core/core.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { EntitiesResultsComponent } from './entities-results/entities-results.component';
import { EntitiesSearchComponent } from './entities-search/entities-search.component';
import { EntitiesViewComponent } from './entities-view/entities-view.component';
import { EntitiesComponent } from './entities.component';

describe('EntitiesComponent', () => {
    let component: EntitiesComponent;
    let fixture: ComponentFixture<EntitiesComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [EntitiesComponent, EntitiesSearchComponent, EntitiesResultsComponent, EntitiesViewComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule, SharedPipesModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(EntitiesComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
