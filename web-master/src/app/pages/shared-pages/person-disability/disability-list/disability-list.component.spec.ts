import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DisabilityListComponent } from './disability-list.component';

describe('DisabilityListComponent', () => {
  let component: DisabilityListComponent;
  let fixture: ComponentFixture<DisabilityListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DisabilityListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DisabilityListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
