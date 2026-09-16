import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { Title4eComponent } from './title4e.component';

describe('Title4eComponent', () => {
  let component: Title4eComponent;
  let fixture: ComponentFixture<Title4eComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ Title4eComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(Title4eComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
