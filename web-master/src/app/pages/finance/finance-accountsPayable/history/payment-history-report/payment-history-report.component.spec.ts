import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PaymentHistoryReportComponent } from './payment-history-report.component';

describe('PaymentHistoryReportComponent', () => {
  let component: PaymentHistoryReportComponent;
  let fixture: ComponentFixture<PaymentHistoryReportComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PaymentHistoryReportComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PaymentHistoryReportComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
