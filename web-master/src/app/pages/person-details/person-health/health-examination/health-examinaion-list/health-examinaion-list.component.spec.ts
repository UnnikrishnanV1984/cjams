import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { HealthExaminaionListComponent } from './health-examinaion-list.component';

describe('HealthExaminaionListComponent', () => {
  let component: HealthExaminaionListComponent;
  let fixture: ComponentFixture<HealthExaminaionListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ HealthExaminaionListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HealthExaminaionListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
