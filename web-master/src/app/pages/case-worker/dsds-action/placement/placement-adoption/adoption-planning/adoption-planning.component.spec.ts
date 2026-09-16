import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionPlanningComponent } from './adoption-planning.component';

describe('AdoptionPlanningComponent', () => {
  let component: AdoptionPlanningComponent;
  let fixture: ComponentFixture<AdoptionPlanningComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionPlanningComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionPlanningComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
