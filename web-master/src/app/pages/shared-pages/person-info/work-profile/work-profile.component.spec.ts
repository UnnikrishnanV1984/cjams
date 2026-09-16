import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { WorkProfileComponent } from './work-profile.component';

describe('PersonProfileComponent', () => {
  let component: WorkProfileComponent;
  let fixture: ComponentFixture<WorkProfileComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ WorkProfileComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WorkProfileComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
