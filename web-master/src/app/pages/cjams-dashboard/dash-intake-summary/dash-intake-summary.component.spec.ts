import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashIntakeSummaryComponent } from './dash-intake-summary.component';

describe('DashIntakeSummaryComponent', () => {
  let component: DashIntakeSummaryComponent;
  let fixture: ComponentFixture<DashIntakeSummaryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashIntakeSummaryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashIntakeSummaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
