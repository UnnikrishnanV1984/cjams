import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakePrivateAdoptionComponent } from './intake-private-adoption.component';

describe('IntakePrivateAdoptionComponent', () => {
  let component: IntakePrivateAdoptionComponent;
  let fixture: ComponentFixture<IntakePrivateAdoptionComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakePrivateAdoptionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakePrivateAdoptionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
