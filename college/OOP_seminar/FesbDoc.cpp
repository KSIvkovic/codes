
// FesbDoc.cpp : implementation of the CFesbDoc class
//

#include "stdafx.h"
// SHARED_HANDLERS can be defined in an ATL project implementing preview, thumbnail
// and search filter handlers and allows sharing of document code with that project.
#ifndef SHARED_HANDLERS
#include "Fesb.h"
#endif

#include "FesbDoc.h"

#include <propkey.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CFesbDoc

IMPLEMENT_DYNCREATE(CFesbDoc, CDocument)

BEGIN_MESSAGE_MAP(CFesbDoc, CDocument)
END_MESSAGE_MAP()


// CFesbDoc construction/destruction

CFesbDoc::CFesbDoc()
{
	// TODO: add one-time construction code here
	m_text="Hello World";
	m_pos.SetPoint(0,0);
    bold=FW_NORMAL;
    italic=FALSE;
    underline=FALSE;
}

CFesbDoc::~CFesbDoc()
{
}

BOOL CFesbDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: add reinitialization code here
	// (SDI documents will reuse this document)

	return TRUE;
}




// CFesbDoc serialization

void CFesbDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		ar<<'F'<<'E'<<'S'<<'B';
		ar<<m_pos;
		ar<<m_text;
	}
	else
	{
		char c1,c2,c3,c4;
		ar>>c1>>c2>>c3>>c4;
		if(c1!='F'||c2!='E'||c3!='S'||c4!='B')
		{
			AfxMessageBox("Ovo nije fesb datoteka"); return;
		}
		ar>>m_pos;
		ar>>m_text;
	}
}

#ifdef SHARED_HANDLERS

// Support for thumbnails
void CFesbDoc::OnDrawThumbnail(CDC& dc, LPRECT lprcBounds)
{
	// Modify this code to draw the document's data
	dc.FillSolidRect(lprcBounds, RGB(255, 255, 255));

	CString strText = _T("TODO: implement thumbnail drawing here");
	LOGFONT lf;

	CFont* pDefaultGUIFont = CFont::FromHandle((HFONT) GetStockObject(DEFAULT_GUI_FONT));
	pDefaultGUIFont->GetLogFont(&lf);
	lf.lfHeight = 36;

	CFont fontDraw;
	fontDraw.CreateFontIndirect(&lf);

	CFont* pOldFont = dc.SelectObject(&fontDraw);
	dc.DrawText(strText, lprcBounds, DT_CENTER | DT_WORDBREAK);
	dc.SelectObject(pOldFont);
}

// Support for Search Handlers
void CFesbDoc::InitializeSearchContent()
{
	CString strSearchContent;
	// Set search contents from document's data. 
	// The content parts should be separated by ";"

	// For example:  strSearchContent = _T("point;rectangle;circle;ole object;");
	SetSearchContent(strSearchContent);
}

void CFesbDoc::SetSearchContent(const CString& value)
{
	if (value.IsEmpty())
	{
		RemoveChunk(PKEY_Search_Contents.fmtid, PKEY_Search_Contents.pid);
	}
	else
	{
		CMFCFilterChunkValueImpl *pChunk = NULL;
		ATLTRY(pChunk = new CMFCFilterChunkValueImpl);
		if (pChunk != NULL)
		{
			pChunk->SetTextValue(PKEY_Search_Contents, value, CHUNK_TEXT);
			SetChunkValue(pChunk);
		}
	}
}

#endif // SHARED_HANDLERS

// CFesbDoc diagnostics

#ifdef _DEBUG
void CFesbDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CFesbDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG


// CFesbDoc commands
