import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ConservedAcBalanceAlertComponent } from './conserved-ac-balance-alert.component';

describe('ConservedAcBalanceAlertComponent', () => {
  let component: ConservedAcBalanceAlertComponent;
  let fixture: ComponentFixture<ConservedAcBalanceAlertComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ConservedAcBalanceAlertComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ConservedAcBalanceAlertComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
