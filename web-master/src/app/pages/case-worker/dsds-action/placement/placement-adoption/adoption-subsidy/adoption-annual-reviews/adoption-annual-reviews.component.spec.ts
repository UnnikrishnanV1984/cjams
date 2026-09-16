import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionAnnualReviewsComponent } from './adoption-annual-reviews.component';

describe('AdoptionAnnualReviewsComponent', () => {
  let component: AdoptionAnnualReviewsComponent;
  let fixture: ComponentFixture<AdoptionAnnualReviewsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionAnnualReviewsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionAnnualReviewsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
