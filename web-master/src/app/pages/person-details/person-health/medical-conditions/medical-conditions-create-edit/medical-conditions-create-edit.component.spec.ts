import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { MedicalConditionsCreateEditComponent } from './medical-conditions-create-edit.component';

describe('MedicalConditionsCreateEditComponent', () => {
  let component: MedicalConditionsCreateEditComponent;
  let fixture: ComponentFixture<MedicalConditionsCreateEditComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MedicalConditionsCreateEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MedicalConditionsCreateEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
