import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { HealthExaminationComponent } from './health-examination.component';

describe('HealthExaminationComponent', () => {
  let component: HealthExaminationComponent;
  let fixture: ComponentFixture<HealthExaminationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ HealthExaminationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HealthExaminationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
