import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FundingAllocationDetailsComponent } from './funding-allocation-details.component';

describe('FundingAllocationDetailsComponent', () => {
  let component: FundingAllocationDetailsComponent;
  let fixture: ComponentFixture<FundingAllocationDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FundingAllocationDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FundingAllocationDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
