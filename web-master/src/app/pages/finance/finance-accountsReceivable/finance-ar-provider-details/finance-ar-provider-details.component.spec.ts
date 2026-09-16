import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FinanceArProviderDetailsComponent } from './finance-ar-provider-details.component';

describe('FinanceArProviderDetailsComponent', () => {
  let component: FinanceArProviderDetailsComponent;
  let fixture: ComponentFixture<FinanceArProviderDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FinanceArProviderDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FinanceArProviderDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
