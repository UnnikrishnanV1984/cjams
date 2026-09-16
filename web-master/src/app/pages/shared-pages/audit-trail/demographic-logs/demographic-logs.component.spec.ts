import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DemographicLogsComponent } from './demographic-logs.component';

describe('DemographicLogsComponent', () => {
  let component: DemographicLogsComponent;
  let fixture: ComponentFixture<DemographicLogsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DemographicLogsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DemographicLogsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
