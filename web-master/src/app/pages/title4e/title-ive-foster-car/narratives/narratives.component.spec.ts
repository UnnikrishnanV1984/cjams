import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import {  NarrativesComponent } from './narratives.component';

describe(' NarrativesComponent', () => {
  let component:  NarrativesComponent;
  let fixture: ComponentFixture< NarrativesComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [  NarrativesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent( NarrativesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
