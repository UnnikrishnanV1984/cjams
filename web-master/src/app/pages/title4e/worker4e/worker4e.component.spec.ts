import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { Worker4eComponent } from './worker4e.component';

describe('Worker4eComponent', () => {
  let component: Worker4eComponent;
  let fixture: ComponentFixture<Worker4eComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ Worker4eComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(Worker4eComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
