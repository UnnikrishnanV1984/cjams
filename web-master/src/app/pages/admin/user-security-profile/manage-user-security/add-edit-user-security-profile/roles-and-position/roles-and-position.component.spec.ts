import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { RolesAndPositionComponent } from './roles-and-position.component';

describe('RolesAndPositionComponent', () => {
  let component: RolesAndPositionComponent;
  let fixture: ComponentFixture<RolesAndPositionComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ RolesAndPositionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RolesAndPositionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
