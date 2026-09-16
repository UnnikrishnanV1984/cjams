import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AsMaltreatmentInformationComponent } from './as-maltreatment-information.component';

describe('AsMaltreatmentInformationComponent', () => {
  let component: AsMaltreatmentInformationComponent;
  let fixture: ComponentFixture<AsMaltreatmentInformationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AsMaltreatmentInformationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AsMaltreatmentInformationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
