import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { MedicationIncludingPsychotropicCwComponent } from './medication-including-psychotropic-cw.component';

describe('MedicationIncludingPsychotropicCwComponent', () => {
  let component: MedicationIncludingPsychotropicCwComponent;
  let fixture: ComponentFixture<MedicationIncludingPsychotropicCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MedicationIncludingPsychotropicCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MedicationIncludingPsychotropicCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
