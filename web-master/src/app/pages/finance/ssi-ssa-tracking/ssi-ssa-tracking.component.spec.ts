import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SsiSsaTrackingComponent } from './ssi-ssa-tracking.component';

describe('SsiSsaTrackingComponent', () => {
  let component: SsiSsaTrackingComponent;
  let fixture: ComponentFixture<SsiSsaTrackingComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SsiSsaTrackingComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SsiSsaTrackingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
