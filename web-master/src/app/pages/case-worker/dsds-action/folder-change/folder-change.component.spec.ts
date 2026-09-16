import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FolderChangeComponent } from './folder-change.component';

describe('FolderChangeComponent', () => {
  let component: FolderChangeComponent;
  let fixture: ComponentFixture<FolderChangeComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FolderChangeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FolderChangeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
