import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FinanceFosterCareRateComponent } from './finance-foster-care-rate.component';

describe('FinanceFosterCareRateComponent', () => {
  let component: FinanceFosterCareRateComponent;
  let fixture: ComponentFixture<FinanceFosterCareRateComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FinanceFosterCareRateComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FinanceFosterCareRateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
