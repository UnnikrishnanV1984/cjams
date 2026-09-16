import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ApAdoptionEffortsComponent } from './ap-adoption-efforts.component';

describe('ApAdoptionEffortsComponent', () => {
  let component: ApAdoptionEffortsComponent;
  let fixture: ComponentFixture<ApAdoptionEffortsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ApAdoptionEffortsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ApAdoptionEffortsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
