import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InvestigationSummaryReportComponent } from './investigation-summary-report.component';

describe('InvestigationSummaryReportComponent', () => {
  let component: InvestigationSummaryReportComponent;
  let fixture: ComponentFixture<InvestigationSummaryReportComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InvestigationSummaryReportComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InvestigationSummaryReportComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
