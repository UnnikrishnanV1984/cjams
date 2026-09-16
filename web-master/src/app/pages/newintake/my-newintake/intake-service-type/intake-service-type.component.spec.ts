import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeServiceTypeComponent } from './intake-service-type.component';

describe('IntakeServiceTypeComponent', () => {
  let component: IntakeServiceTypeComponent;
  let fixture: ComponentFixture<IntakeServiceTypeComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeServiceTypeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeServiceTypeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
