import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PhysicianInformationCreateEditComponent } from './physician-information-create-edit.component';

describe('PhysicianInformationCreateEditComponent', () => {
  let component: PhysicianInformationCreateEditComponent;
  let fixture: ComponentFixture<PhysicianInformationCreateEditComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PhysicianInformationCreateEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PhysicianInformationCreateEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
