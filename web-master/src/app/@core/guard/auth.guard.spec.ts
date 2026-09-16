import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { inject, TestBed } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
//SonarQube -removed the unused HttpClient import
import { ControlMessagesModule } from '../../shared/modules/control-messages/control-messages.module';
import { CoreModule } from '../core.module';
import { SharedPipesModule } from '../pipes/shared-pipes.module';
import { AuthService, SessionStorageService } from '../services';
import { HttpService } from '../services/http.service';
import { AuthGuard } from './auth.guard';

describe('AuthGuard', () => {
    beforeEach(() => {
        TestBed.configureTestingModule({
    imports: [RouterTestingModule,
        CoreModule.forRoot(),
        FormsModule,
        ReactiveFormsModule,
        ControlMessagesModule,
        PaginationModule,
        NgSelectModule,
        A2Edatetimepicker,
        SharedPipesModule,
        RouterModule],
    providers: [AuthGuard, AuthService, SessionStorageService, HttpService, provideHttpClient(withInterceptorsFromDi())]
});
    });

    it('should ...', inject([AuthGuard], (guard: AuthGuard) => {
        expect(guard).toBeTruthy();
    }));
});
