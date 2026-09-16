import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { HospitalizationCwComponent } from './hospitalization-cw.component';

describe('HospitalizationCwComponent', () => {
  let component: HospitalizationCwComponent;
  let fixture: ComponentFixture<HospitalizationCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ HospitalizationCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HospitalizationCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
