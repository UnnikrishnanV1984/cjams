import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PhysicianInformationListComponent } from './physician-information-list.component';

describe('PhysicianInformationListComponent', () => {
  let component: PhysicianInformationListComponent;
  let fixture: ComponentFixture<PhysicianInformationListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PhysicianInformationListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PhysicianInformationListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
