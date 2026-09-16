import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FundingAllocationSearchComponent } from './funding-allocation-search.component';

describe('FundingAllocationSearchComponent', () => {
  let component: FundingAllocationSearchComponent;
  let fixture: ComponentFixture<FundingAllocationSearchComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FundingAllocationSearchComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FundingAllocationSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
