import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonClientAppointmentsComponent } from './person-client-appointments.component';

describe('PersonClientAppointmentsComponent', () => {
  let component: PersonClientAppointmentsComponent;
  let fixture: ComponentFixture<PersonClientAppointmentsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonClientAppointmentsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonClientAppointmentsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
