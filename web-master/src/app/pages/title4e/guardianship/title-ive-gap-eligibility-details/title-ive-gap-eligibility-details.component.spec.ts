import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TitleIveGapEligibilityDetailsComponent } from './title-ive-gap-eligibility-details.component';

describe('TitleIveGapEligibilityDetailsComponent', () => {
  let component: TitleIveGapEligibilityDetailsComponent;
  let fixture: ComponentFixture<TitleIveGapEligibilityDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ TitleIveGapEligibilityDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TitleIveGapEligibilityDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
