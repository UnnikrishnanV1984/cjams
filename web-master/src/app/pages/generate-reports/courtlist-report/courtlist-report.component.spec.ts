import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CourtlistReportComponent } from './courtlist-report.component';

describe('CourtlistReportComponent', () => {
  let component: CourtlistReportComponent;
  let fixture: ComponentFixture<CourtlistReportComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CourtlistReportComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CourtlistReportComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
