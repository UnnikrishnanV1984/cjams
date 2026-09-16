import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ApplaListComponent } from './appla-list.component';

describe('ApplaListComponent', () => {
  let component: ApplaListComponent;
  let fixture: ComponentFixture<ApplaListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ApplaListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ApplaListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
