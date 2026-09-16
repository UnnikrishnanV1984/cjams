import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { StaffReadonlyPageComponent } from './staff-readonly-page.component';

describe('StaffReadonlyPageComponent', () => {
  let component: StaffReadonlyPageComponent;
  let fixture: ComponentFixture<StaffReadonlyPageComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ StaffReadonlyPageComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StaffReadonlyPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
