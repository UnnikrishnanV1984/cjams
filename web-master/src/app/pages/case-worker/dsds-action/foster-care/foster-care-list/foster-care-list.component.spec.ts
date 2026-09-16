import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FosterCareListComponent } from './foster-care-list.component';

describe('FosterCareListComponent', () => {
  let component: FosterCareListComponent;
  let fixture: ComponentFixture<FosterCareListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FosterCareListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FosterCareListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
