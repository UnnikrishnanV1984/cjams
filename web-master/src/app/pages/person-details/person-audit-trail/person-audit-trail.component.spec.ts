import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonAuditTrailComponent } from './person-audit-trail.component';

describe('PersonAuditTrailComponent', () => {
  let component: PersonAuditTrailComponent;
  let fixture: ComponentFixture<PersonAuditTrailComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonAuditTrailComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonAuditTrailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
