import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InsuranceInformationCwComponent } from './insurance-information-cw.component';

describe('InsuranceInformationCwComponent', () => {
  let component: InsuranceInformationCwComponent;
  let fixture: ComponentFixture<InsuranceInformationCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InsuranceInformationCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InsuranceInformationCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
