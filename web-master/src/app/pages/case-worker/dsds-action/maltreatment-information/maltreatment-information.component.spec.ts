import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { MaltreatmentInformationComponent } from './maltreatment-information.component';

describe('MaltreatmentInformationComponent', () => {
  let component: MaltreatmentInformationComponent;
  let fixture: ComponentFixture<MaltreatmentInformationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MaltreatmentInformationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MaltreatmentInformationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
