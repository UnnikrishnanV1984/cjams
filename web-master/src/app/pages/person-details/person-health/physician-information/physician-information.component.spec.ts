import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PhysicianInformationComponent } from './physician-information.component';

describe('PhysicianInformationComponent', () => {
  let component: PhysicianInformationComponent;
  let fixture: ComponentFixture<PhysicianInformationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PhysicianInformationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PhysicianInformationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
