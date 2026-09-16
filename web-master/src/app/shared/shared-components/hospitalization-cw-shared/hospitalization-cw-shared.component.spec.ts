import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HospitalizationCwSharedComponent } from './hospitalization-cw-shared.component';

describe('HospitalizationCwSharedComponent', () => {
  let component: HospitalizationCwSharedComponent;
  let fixture: ComponentFixture<HospitalizationCwSharedComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ HospitalizationCwSharedComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(HospitalizationCwSharedComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
