import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FundingAllocationResultComponent } from './funding-allocation-result.component';

describe('FundingAllocationResultComponent', () => {
  let component: FundingAllocationResultComponent;
  let fixture: ComponentFixture<FundingAllocationResultComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FundingAllocationResultComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FundingAllocationResultComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
