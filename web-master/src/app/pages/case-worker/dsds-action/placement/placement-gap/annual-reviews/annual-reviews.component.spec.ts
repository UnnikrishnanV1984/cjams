import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AnnualReviewsComponent } from './annual-reviews.component';

describe('AnnualReviewsComponent', () => {
  let component: AnnualReviewsComponent;
  let fixture: ComponentFixture<AnnualReviewsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AnnualReviewsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AnnualReviewsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
