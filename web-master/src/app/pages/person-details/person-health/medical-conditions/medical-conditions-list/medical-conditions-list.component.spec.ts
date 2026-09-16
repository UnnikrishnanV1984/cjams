import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { MedicalConditionsListComponent } from './medical-conditions-list.component';

describe('MedicalConditionsListComponent', () => {
  let component: MedicalConditionsListComponent;
  let fixture: ComponentFixture<MedicalConditionsListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MedicalConditionsListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MedicalConditionsListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
