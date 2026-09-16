import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../../../@core/core.module';
import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { ControlMessagesModule } from '../../../../../shared/modules/control-messages/control-messages.module';
import { PersonRolesComponent } from './person-roles.component';

describe('PersonRolesComponent', () => {
    let component: PersonRolesComponent;
    let fixture: ComponentFixture<PersonRolesComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [PersonRolesComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule, SharedPipesModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(PersonRolesComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
