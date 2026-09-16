import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { LivingArrangmentDetailsComponent } from './living-arrangment-details.component';

describe('LivingArrangmentDetailsComponent', () => {
  let component: LivingArrangmentDetailsComponent;
  let fixture: ComponentFixture<LivingArrangmentDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ LivingArrangmentDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LivingArrangmentDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
