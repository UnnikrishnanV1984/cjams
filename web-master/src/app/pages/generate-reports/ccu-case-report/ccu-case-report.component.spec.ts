import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CcuCaseReportComponent } from './ccu-case-report.component';

describe('CcuCaseReportComponent', () => {
  let component: CcuCaseReportComponent;
  let fixture: ComponentFixture<CcuCaseReportComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CcuCaseReportComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CcuCaseReportComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
