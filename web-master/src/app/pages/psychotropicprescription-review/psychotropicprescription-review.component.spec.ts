import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PsychotropicprescriptionReviewComponent } from './psychotropicprescription-review.component';

describe('PsychotropicprescriptionReviewComponent', () => {
  let component: PsychotropicprescriptionReviewComponent;
  let fixture: ComponentFixture<PsychotropicprescriptionReviewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [PsychotropicprescriptionReviewComponent]
    })
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PsychotropicprescriptionReviewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
