import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FinancePayableApprovalComponent } from './finance-payable-approval.component';

describe('FinancePayableApprovalComponent', () => {
  let component: FinancePayableApprovalComponent;
  let fixture: ComponentFixture<FinancePayableApprovalComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FinancePayableApprovalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FinancePayableApprovalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
