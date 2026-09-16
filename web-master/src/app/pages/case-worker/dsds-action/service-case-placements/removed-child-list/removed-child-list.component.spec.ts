import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { RemovedChildListComponent } from './removed-child-list.component';

describe('RemovedChildListComponent', () => {
  let component: RemovedChildListComponent;
  let fixture: ComponentFixture<RemovedChildListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ RemovedChildListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RemovedChildListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
