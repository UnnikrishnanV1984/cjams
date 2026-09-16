import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PaymentScheduleDocumentComponent } from './payment-schedule-document.component';

describe('PaymentScheduleDocumentComponent', () => {
  let component: PaymentScheduleDocumentComponent;
  let fixture: ComponentFixture<PaymentScheduleDocumentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PaymentScheduleDocumentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PaymentScheduleDocumentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
