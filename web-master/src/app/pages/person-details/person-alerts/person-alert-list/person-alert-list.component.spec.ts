import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonAlertListComponent } from './person-alert-list.component';

describe('PersonAlertListComponent', () => {
  let component: PersonAlertListComponent;
  let fixture: ComponentFixture<PersonAlertListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonAlertListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonAlertListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
