import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AncillaryPaymentAdjustmentComponent } from './ancillary-payment-adjustment.component';

describe('AncillaryPaymentAdjustmentComponent', () => {
  let component: AncillaryPaymentAdjustmentComponent;
  let fixture: ComponentFixture<AncillaryPaymentAdjustmentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AncillaryPaymentAdjustmentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AncillaryPaymentAdjustmentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
