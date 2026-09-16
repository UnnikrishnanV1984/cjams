import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeHistoryClearanceComponent } from './intake-history-clearance.component';

describe('IntakeHistoryClearanceComponent', () => {
  let component: IntakeHistoryClearanceComponent;
  let fixture: ComponentFixture<IntakeHistoryClearanceComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeHistoryClearanceComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeHistoryClearanceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
