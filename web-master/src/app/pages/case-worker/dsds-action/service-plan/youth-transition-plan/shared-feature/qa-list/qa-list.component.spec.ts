import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { QaListComponent } from './qa-list.component';

describe('QaListComponent', () => {
  let component: QaListComponent;
  let fixture: ComponentFixture<QaListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ QaListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(QaListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
