import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { BirthInformationCwComponent } from './birth-information-cw.component';

describe('BirthInformationCwComponent', () => {
  let component: BirthInformationCwComponent;
  let fixture: ComponentFixture<BirthInformationCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ BirthInformationCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BirthInformationCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
