import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FinanceAdjustmentComponent } from './finance-adjustment.component';

describe('FinanceAdjustmentComponent', () => {
  let component: FinanceAdjustmentComponent;
  let fixture: ComponentFixture<FinanceAdjustmentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FinanceAdjustmentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FinanceAdjustmentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
