import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InfoSubsidyReviewsComponent } from './info-subsidy-reviews.component';

describe('InfoSubsidyReviewsComponent', () => {
  let component: InfoSubsidyReviewsComponent;
  let fixture: ComponentFixture<InfoSubsidyReviewsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InfoSubsidyReviewsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InfoSubsidyReviewsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
