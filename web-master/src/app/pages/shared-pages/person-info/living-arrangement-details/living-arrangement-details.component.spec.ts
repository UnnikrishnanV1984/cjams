import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { LivingArrangementDetailsComponent } from './living-arrangement-details.component';

describe('LivingArrangementDetailsComponent', () => {
  let component: LivingArrangementDetailsComponent;
  let fixture: ComponentFixture<LivingArrangementDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ LivingArrangementDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LivingArrangementDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
