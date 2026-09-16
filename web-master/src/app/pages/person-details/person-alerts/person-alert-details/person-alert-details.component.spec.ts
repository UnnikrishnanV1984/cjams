import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonAlertDetailsComponent } from './person-alert-details.component';

describe('PersonAlertDetailsComponent', () => {
  let component: PersonAlertDetailsComponent;
  let fixture: ComponentFixture<PersonAlertDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonAlertDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonAlertDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
