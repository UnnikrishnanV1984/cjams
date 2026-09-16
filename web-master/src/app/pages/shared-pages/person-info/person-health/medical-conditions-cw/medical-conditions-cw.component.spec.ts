import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { MedicalConditionsCwComponent } from './medical-conditions-cw.component';

describe('MedicalConditionsComponent', () => {
  let component: MedicalConditionsCwComponent;
  let fixture: ComponentFixture<MedicalConditionsCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MedicalConditionsCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MedicalConditionsCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
