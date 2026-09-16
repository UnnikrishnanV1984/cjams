import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterTestingModule } from '@angular/router/testing';
import { NgSelectModule } from '@ng-select/ng-select';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';

import { CoreModule } from '../../../@core/core.module';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { AddEditRecordingTypeComponent } from './add-edit-recording-type.component';
import { RecordingTypeComponent } from './recording-type.component';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

describe('RecordingTypeComponent', () => {
    let component: RecordingTypeComponent;
    let fixture: ComponentFixture<RecordingTypeComponent>;

    beforeEach(waitForAsync(() => {
        TestBed.configureTestingModule({
    declarations: [RecordingTypeComponent, AddEditRecordingTypeComponent],
    imports: [RouterTestingModule, CoreModule.forRoot(), FormsModule, ReactiveFormsModule, ControlMessagesModule, PaginationModule, NgSelectModule,
        // A2Edatetimepicker, 
        SharedPipesModule],
    providers: [provideHttpClient(withInterceptorsFromDi())]
}).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent(RecordingTypeComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
