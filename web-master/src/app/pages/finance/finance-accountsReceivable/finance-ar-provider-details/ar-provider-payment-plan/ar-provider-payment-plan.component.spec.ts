import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ArProviderPaymentPlanComponent } from './ar-provider-payment-plan.component';

describe('ArProviderPaymentPlanComponent', () => {
  let component: ArProviderPaymentPlanComponent;
  let fixture: ComponentFixture<ArProviderPaymentPlanComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ArProviderPaymentPlanComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ArProviderPaymentPlanComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
