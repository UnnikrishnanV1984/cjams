import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DentalInformationCwComponent } from './dental-information-cw.component';

describe('DentalInformationCwComponent', () => {
  let component: DentalInformationCwComponent;
  let fixture: ComponentFixture<DentalInformationCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DentalInformationCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DentalInformationCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
