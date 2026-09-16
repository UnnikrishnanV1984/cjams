import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashMyIntakeSummaryComponent } from './dash-my-intake-summary.component';

describe('DashMyIntakeSummaryComponent', () => {
  let component: DashMyIntakeSummaryComponent;
  let fixture: ComponentFixture<DashMyIntakeSummaryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashMyIntakeSummaryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashMyIntakeSummaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
