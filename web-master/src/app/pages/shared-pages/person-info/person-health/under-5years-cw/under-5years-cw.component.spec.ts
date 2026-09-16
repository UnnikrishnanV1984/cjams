import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { Under5yearsCwComponent } from './under-5years-cw.component';

describe('Under5yearsCwComponent', () => {
  let component: Under5yearsCwComponent;
  let fixture: ComponentFixture<Under5yearsCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ Under5yearsCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(Under5yearsCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
