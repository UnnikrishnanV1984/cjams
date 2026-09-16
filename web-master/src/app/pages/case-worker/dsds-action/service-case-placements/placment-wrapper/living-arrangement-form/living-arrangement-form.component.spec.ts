import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { LivingArrangementFormComponent } from './living-arrangement-form.component';

describe('LivingArrangementFormComponent', () => {
  let component: LivingArrangementFormComponent;
  let fixture: ComponentFixture<LivingArrangementFormComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ LivingArrangementFormComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LivingArrangementFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
