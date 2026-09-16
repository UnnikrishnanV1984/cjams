import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ImmunizationCwComponent } from './immunization-cw.component';

describe('ImmunizationCwComponent', () => {
  let component: ImmunizationCwComponent;
  let fixture: ComponentFixture<ImmunizationCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ImmunizationCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ImmunizationCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
