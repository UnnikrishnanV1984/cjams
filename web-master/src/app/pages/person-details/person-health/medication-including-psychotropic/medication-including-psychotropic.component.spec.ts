import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { MedicationIncludingPsychotropicComponent } from './medication-including-psychotropic.component';

describe('MedicationIncludingPsychotropicComponent', () => {
  let component: MedicationIncludingPsychotropicComponent;
  let fixture: ComponentFixture<MedicationIncludingPsychotropicComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MedicationIncludingPsychotropicComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MedicationIncludingPsychotropicComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
