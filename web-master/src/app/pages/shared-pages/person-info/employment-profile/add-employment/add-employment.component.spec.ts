import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AddEmploymentComponent } from './add-employment.component';

describe('AddEmploymentComponent', () => {
  let component: AddEmploymentComponent;
  let fixture: ComponentFixture<AddEmploymentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AddEmploymentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AddEmploymentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
