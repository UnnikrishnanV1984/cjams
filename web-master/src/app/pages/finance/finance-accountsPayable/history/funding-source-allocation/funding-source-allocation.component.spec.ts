import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FundingSourceAllocationComponent } from './funding-source-allocation.component';

describe('FundingSourceAllocationComponent', () => {
  let component: FundingSourceAllocationComponent;
  let fixture: ComponentFixture<FundingSourceAllocationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FundingSourceAllocationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FundingSourceAllocationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
