import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DocumentUploadListSharedComponent } from './document-upload-list-shared.component';

describe('DocumentUploadListSharedComponent', () => {
  let component: DocumentUploadListSharedComponent;
  let fixture: ComponentFixture<DocumentUploadListSharedComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DocumentUploadListSharedComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DocumentUploadListSharedComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
