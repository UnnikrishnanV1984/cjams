import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { LevelReportComponent } from './level-report.component';

describe('LevelReportComponent', () => {
  let component: LevelReportComponent;
  let fixture: ComponentFixture<LevelReportComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ LevelReportComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LevelReportComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
