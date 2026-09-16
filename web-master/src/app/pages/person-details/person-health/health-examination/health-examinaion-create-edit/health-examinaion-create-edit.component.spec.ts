import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { HealthExaminaionCreateEditComponent } from './health-examinaion-create-edit.component';

describe('HealthExaminaionCreateEditComponent', () => {
  let component: HealthExaminaionCreateEditComponent;
  let fixture: ComponentFixture<HealthExaminaionCreateEditComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ HealthExaminaionCreateEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HealthExaminaionCreateEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
