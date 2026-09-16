/* tslint:disable:no-unused-variable */
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AssessmentSexTraffickingComponent } from './assessment-sex-trafficking.component';

describe('AssessmentSexTraffickingComponent', () => {
  let component: AssessmentSexTraffickingComponent;
  let fixture: ComponentFixture<AssessmentSexTraffickingComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AssessmentSexTraffickingComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AssessmentSexTraffickingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
