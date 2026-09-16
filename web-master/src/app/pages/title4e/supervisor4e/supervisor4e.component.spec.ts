import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { Supervisor4eComponent } from './supervisor4e.component';

describe('Supervisor4eComponent', () => {
  let component: Supervisor4eComponent;
  let fixture: ComponentFixture<Supervisor4eComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ Supervisor4eComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(Supervisor4eComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
