import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TitleIveGapeligibilityComponent } from './title-ive-gapeligibility.component';

describe('TitleIveGapeligibilityComponent', () => {
  let component: TitleIveGapeligibilityComponent;
  let fixture: ComponentFixture<TitleIveGapeligibilityComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ TitleIveGapeligibilityComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TitleIveGapeligibilityComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
