import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonStatusSummaryComponent } from './person-status-summary.component';

describe('PersonStatusSummaryComponent', () => {
  let component: PersonStatusSummaryComponent;
  let fixture: ComponentFixture<PersonStatusSummaryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonStatusSummaryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonStatusSummaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
