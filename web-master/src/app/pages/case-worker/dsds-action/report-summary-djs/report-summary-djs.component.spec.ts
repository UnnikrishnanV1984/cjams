import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ReportSummaryDjsComponent } from './report-summary-djs.component';

describe('ReportSummaryDjsComponent', () => {
  let component: ReportSummaryDjsComponent;
  let fixture: ComponentFixture<ReportSummaryDjsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ReportSummaryDjsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ReportSummaryDjsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
