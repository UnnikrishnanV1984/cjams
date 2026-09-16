import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CasePlanComponent } from './case-plan.component';

describe('CasePlanComponent', () => {
  let component: CasePlanComponent;
  let fixture: ComponentFixture<CasePlanComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CasePlanComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CasePlanComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
