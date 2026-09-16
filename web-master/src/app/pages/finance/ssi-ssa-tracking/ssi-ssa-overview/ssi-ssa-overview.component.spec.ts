import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SsiSsaOverviewComponent } from './ssi-ssa-overview.component';

describe('SsiSsaOverviewComponent', () => {
  let component: SsiSsaOverviewComponent;
  let fixture: ComponentFixture<SsiSsaOverviewComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SsiSsaOverviewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SsiSsaOverviewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
