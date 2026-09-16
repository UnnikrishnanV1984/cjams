import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { MedicationIncludingPsychotropicListComponent } from './medication-including-psychotropic-list.component';

describe('MedicationIncludingPsychotropicListComponent', () => {
  let component: MedicationIncludingPsychotropicListComponent;
  let fixture: ComponentFixture<MedicationIncludingPsychotropicListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MedicationIncludingPsychotropicListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MedicationIncludingPsychotropicListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
