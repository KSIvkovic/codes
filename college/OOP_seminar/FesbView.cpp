
// FesbView.cpp : implementation of the CFesbView class
//

#include "stdafx.h"
// SHARED_HANDLERS can be defined in an ATL project implementing preview, thumbnail
// and search filter handlers and allows sharing of document code with that project.
#ifndef SHARED_HANDLERS
#include "Fesb.h"
#endif

#include "FesbDoc.h"
#include "FesbView.h"
#include "TxDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CFesbView

IMPLEMENT_DYNCREATE(CFesbView, CView)

BEGIN_MESSAGE_MAP(CFesbView, CView)
	// Standard printing commands
	ON_COMMAND(ID_FILE_PRINT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, &CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, &CFesbView::OnFilePrintPreview)
	ON_WM_CONTEXTMENU()
	ON_WM_RBUTTONUP()
	ON_WM_LBUTTONDOWN()
	ON_WM_KEYDOWN()
	ON_COMMAND(ID_EDIT_NOVITEKST, &CFesbView::OnEditNovitekst)
	ON_WM_RBUTTONDOWN()
	ON_COMMAND(ID_EDIT_ITALIC, &CFesbView::OnEditItalic)
	ON_COMMAND(ID_EDIT_BOLD, &CFesbView::OnEditBold)
	ON_COMMAND(ID_EDIT_UNDERLINE, &CFesbView::OnEditUnderline)
END_MESSAGE_MAP()

// CFesbView construction/destruction

CFesbView::CFesbView()
{
	// TODO: add construction code here

}

CFesbView::~CFesbView()
{
}

BOOL CFesbView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	return CView::PreCreateWindow(cs);
}

// CFesbView drawing

void CFesbView::OnDraw(CDC* pDC)
{
	CFesbDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;
	CFont font;
   VERIFY(font.CreateFont(
   18,                        // nHeight
   0,                         // nWidth
   0,                         // nEscapement
   0,                         // nOrientation
   pDoc->bold,                // nWeight
   pDoc->italic,              // bItalic
   pDoc->underline,           // bUnderline
   0,                         // cStrikeOut
   ANSI_CHARSET,              // nCharSet
   OUT_DEFAULT_PRECIS,        // nOutPrecision
   CLIP_DEFAULT_PRECIS,       // nClipPrecision
   DEFAULT_QUALITY,           // nQuality
   DEFAULT_PITCH | FF_SWISS,  // nPitchAndFamily
   _T("Arial")));             // lpszFacename

// Do something with the font just created...
//CClientDC dc(this);  
CFont* def_font = pDC->SelectObject(&font);
//dc.TextOut(100, 100, _T("Hello"), 5);

// Done with the font.  Delete the font object.
//font.DeleteObject(); 

    //ispisi text
    pDC->SetTextColor(m_txtColor);
    pDC->TextOut(pDoc->m_pos.x,pDoc->m_pos.y,pDoc->m_text);

    pDC->SelectObject(def_font);

// Done with the font.  Delete the font object.
//font.DeleteObject(); 


    //nacrtaj liniju dijagonalno preko cijelog prikaza
    /*CRect r;
    GetClientRect(&r);
    CPen pen;
    pen.CreatePen(PS_SOLID,1,m_penColor);
    CPen *oldpen= pDC->SelectObject(&pen);
    pDC->MoveTo(r.left,r.bottom);
    pDC->LineTo(r.right,r.top);
    pDC->SelectObject(oldpen); // vrati staro stanje*/
    
    CPen pen;
    pen.CreatePen(PS_SOLID,1,m_penColor);
    CPen *oldpen= pDC->SelectObject(&pen);

    
    
    pDC->MoveTo(pDoc->m_posl.x,pDoc->m_posl.y);
    pDC->LineTo(pDoc->m_posl2.x,pDoc->m_posl2.y);
    
    pDC->SelectObject(oldpen); // vrati staro stanje  
}


// CFesbView printing


void CFesbView::OnFilePrintPreview()
{
#ifndef SHARED_HANDLERS
	AFXPrintPreview(this);
#endif
}

BOOL CFesbView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// default preparation
	return DoPreparePrinting(pInfo);
}

void CFesbView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add extra initialization before printing
}

void CFesbView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add cleanup after printing
}

void CFesbView::OnRButtonUp(UINT /* nFlags */, CPoint point)
{
	ClientToScreen(&point);
	OnContextMenu(this, point);
}

void CFesbView::OnContextMenu(CWnd* /* pWnd */, CPoint point)
{
#ifndef SHARED_HANDLERS
	theApp.GetContextMenuManager()->ShowPopupMenu(IDR_POPUP_EDIT, point.x, point.y, this, TRUE);
#endif
}


// CFesbView diagnostics

#ifdef _DEBUG
void CFesbView::AssertValid() const
{
	CView::AssertValid();
}

void CFesbView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CFesbDoc* CFesbView::GetDocument() const // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CFesbDoc)));
	return (CFesbDoc*)m_pDocument;
}
#endif //_DEBUG


// CFesbView message handlers


void CFesbView::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags)
{
	CFesbDoc* pDoc=GetDocument();
	CPoint curr_pos=pDoc->m_pos;
	switch(nChar)
	{
		case VK_UP:		curr_pos.y--; break;
		case VK_DOWN:	curr_pos.y++; break;
		case VK_LEFT:	curr_pos.x--; break;
		case VK_RIGHT:	curr_pos.x++; break;
	}

	CRect r;
	GetClientRect(&r);
	if(curr_pos.y>r.top && curr_pos.y<r.bottom)
		pDoc->m_pos.y=curr_pos.y;
	if(curr_pos.x>r.left && curr_pos.x<r.right)
		pDoc->m_pos.x=curr_pos.x;
	Invalidate();
	CView::OnKeyDown(nChar, nRepCnt, nFlags);
}


void CFesbView::OnEditNovitekst()
{
	CFesbDoc* pDoc=GetDocument();
	CTxDlg dlg;

	int response=dlg.DoModal();

	if(IDOK==response)
	{
		if(dlg.m_text.IsEmpty())
			AfxMessageBox("Pritisnut je meni: NOVI text");
		else
			pDoc->m_text=dlg.m_text;
		Invalidate();
	}

}


void CFesbView::OnRButtonDown(UINT nFlags, CPoint point)
{
	CFesbDoc* pDoc = GetDocument(); 
	pDoc->m_pos = point; // point sadrži koordinate miša 
	Invalidate(); // poruka da se treba obnoviti crtanje View-a

	CView::OnRButtonDown(nFlags, point);
}


void CFesbView::OnLButtonDown(UINT nFlags, CPoint point)
{
    // TODO: Add your message handler code here and/or call default
    CFesbDoc* pDoc = GetDocument();
    
    static bool b=false;
    if(!b)
    {
    pDoc->m_posl = point;
    b=true;
    }
    else
    {
    pDoc->m_posl2 = point;
    b=false;
    Invalidate(); // poruka da se treba obnoviti crtanje View-a

    }

    
    
    //Invalidate(); // poruka da se treba obnoviti crtanje View-a
    
    

    CView::OnLButtonDown(nFlags, point);
}

void CFesbView::OnEditBold()
{
    // TODO: Add your command handler code here
    CFesbDoc* pDoc = GetDocument();
    
    if(pDoc->bold==FW_NORMAL)
    {
        pDoc->bold=FW_BOLD;
        Invalidate();
    }
    else
    {
        pDoc->bold=FW_NORMAL;
        Invalidate();
    }
}


void CFesbView::OnEditItalic()
{
    // TODO: Add your command handler code here
    CFesbDoc* pDoc = GetDocument();
    
    if(pDoc->italic==FALSE)
    {
        pDoc->italic=TRUE;
        Invalidate();
    }
    else
    {
        pDoc->italic=FALSE;
        Invalidate();
    }
}


void CFesbView::OnEditUnderline()
{
    CFesbDoc* pDoc = GetDocument();
    
    if(pDoc->underline==FALSE)
    {
        pDoc->underline=TRUE;
        Invalidate();
    }
    else
    {
        pDoc->underline=FALSE;
        Invalidate();
    }    
}