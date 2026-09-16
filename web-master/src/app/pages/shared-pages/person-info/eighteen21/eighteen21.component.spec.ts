import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { Eighteen21Component } from './eighteen21.component';

describe('EducationComponent', () => {
  let component: Eighteen21Component;
  let fixture: ComponentFixture<Eighteen21Component>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ Eighteen21Component ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(Eighteen21Component);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
