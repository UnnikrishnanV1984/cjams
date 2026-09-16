import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ExaminationAppointmentCreateComponent } from './examination-appointment-create.component';

describe('ExaminationAppointmentCreateComponent', () => {
  let component: ExaminationAppointmentCreateComponent;
  let fixture: ComponentFixture<ExaminationAppointmentCreateComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ExaminationAppointmentCreateComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ExaminationAppointmentCreateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
