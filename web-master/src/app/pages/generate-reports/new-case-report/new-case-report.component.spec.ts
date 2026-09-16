import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { NewCaseReportComponent } from './new-case-report.component';

describe('NewCaseReportComponent', () => {
  let component: NewCaseReportComponent;
  let fixture: ComponentFixture<NewCaseReportComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ NewCaseReportComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(NewCaseReportComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
