import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ServiceCasePlacementsComponent } from './service-case-placements.component';

describe('ServiceCasePlacementsComponent', () => {
  let component: ServiceCasePlacementsComponent;
  let fixture: ComponentFixture<ServiceCasePlacementsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ServiceCasePlacementsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ServiceCasePlacementsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
