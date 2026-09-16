import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FinanceProviderContractRateComponent } from './finance-provider-contract-rate.component';

describe('FinanceProviderContractRateComponent', () => {
  let component: FinanceProviderContractRateComponent;
  let fixture: ComponentFixture<FinanceProviderContractRateComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FinanceProviderContractRateComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FinanceProviderContractRateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
