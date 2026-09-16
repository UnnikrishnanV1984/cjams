import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SexualInformationCwComponent } from './sexual-information-cw.component';

describe('SexualInformationCwComponent', () => {
  let component: SexualInformationCwComponent;
  let fixture: ComponentFixture<SexualInformationCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SexualInformationCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SexualInformationCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
