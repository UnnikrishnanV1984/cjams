import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonAlertsComponent } from './person-alerts.component';

describe('PersonAlertsComponent', () => {
  let component: PersonAlertsComponent;
  let fixture: ComponentFixture<PersonAlertsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonAlertsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonAlertsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
