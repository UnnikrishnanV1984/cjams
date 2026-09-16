import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ProgressReviewComponent } from './progress-review.component';

describe('ProgressReviewComponent', () => {
  let component: ProgressReviewComponent;
  let fixture: ComponentFixture<ProgressReviewComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ProgressReviewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProgressReviewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
