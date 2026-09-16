import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CensusReportComponent } from './census-report.component';

describe('CensusReportComponent', () => {
  let component: CensusReportComponent;
  let fixture: ComponentFixture<CensusReportComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CensusReportComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CensusReportComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
