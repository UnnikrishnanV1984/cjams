import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { StaffMangementComponent } from './staff-mangement.component';

describe('StaffMangementComponent', () => {
  let component: StaffMangementComponent;
  let fixture: ComponentFixture<StaffMangementComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ StaffMangementComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StaffMangementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
