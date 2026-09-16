import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { MedicationIncludingPsychotropicCreateEditComponent } from './medication-including-psychotropic-create-edit.component';

describe('MedicationIncludingPsychotropicCreateEditComponent', () => {
  let component: MedicationIncludingPsychotropicCreateEditComponent;
  let fixture: ComponentFixture<MedicationIncludingPsychotropicCreateEditComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MedicationIncludingPsychotropicCreateEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MedicationIncludingPsychotropicCreateEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
