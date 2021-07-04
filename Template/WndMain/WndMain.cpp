#include <assert.h>
#include "WndMain.h"

CWndMain* CWndMain::pInstance = nullptr;

CWndMain::CWndMain(HINSTANCE hInstance, LPCTSTR lpszClass, LPCTSTR lpszTitle)
{
    this->wcex.cbSize         = sizeof(WNDCLASSEX);
    this->wcex.cbClsExtra     = 0;
    this->wcex.cbWndExtra     = 0;
    this->wcex.hInstance      = hInstance;
    this->wcex.lpfnWndProc    = CWndMain::WndProc;
    this->wcex.hIcon          = LoadIcon(nullptr, IDI_APPLICATION);
    this->wcex.hIconSm        = LoadIcon(nullptr, IDI_APPLICATION);
    this->wcex.hCursor        = LoadCursor(nullptr, IDC_ARROW);
    this->wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW + 1);
    this->wcex.style          = (CS_HREDRAW | CS_VREDRAW);
    this->wcex.lpszMenuName   = nullptr;
    this->wcex.lpszClassName  = lpszClass;
    RegisterClassEx(&this->wcex);

    this->hInstance     = hInstance;
    this->hWnd          = CreateWindow( lpszClass, lpszTitle, WS_OVERLAPPEDWINDOW, 
                                        CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
                                        nullptr, nullptr, hInstance, nullptr);
    assert(this->hWnd != nullptr);
}

CWndMain::~CWndMain()
{
    this->hInstance = nullptr;
    this->hWnd      = nullptr;
    ZeroMemory(&this->wcex, sizeof(WNDCLASSEX));
    ZeroMemory(&this->Message, sizeof(MSG));
}

CWndMain* CWndMain::GetInstance(HINSTANCE hInstance, LPCTSTR lpszClass, LPCTSTR lpszTitle)
{
    if(CWndMain::pInstance == nullptr)
    {
        CWndMain::pInstance = new CWndMain(hInstance, lpszClass, lpszTitle);
        assert(CWndMain::pInstance != nullptr);
    }

    return CWndMain::pInstance;
}

void CWndMain::Release(void)
{
    if(pInstance != nullptr)
    {
        delete CWndMain::pInstance;
        CWndMain::pInstance = nullptr;
    }
}

void CWndMain::ShowWindow(int nCmdShow)
{
    ::ShowWindow(this->hWnd, nCmdShow);
}

int CWndMain::Exec(void)
{
    while(GetMessage(&this->Message, nullptr, 0, 0))
    {
        TranslateMessage(&this->Message);
        DispatchMessage(&this->Message);
    }

    return (int)this->Message.wParam;
}

LRESULT CALLBACK CWndMain::WndProc(HWND hWnd, UINT nMsg, WPARAM wParam, LPARAM lParam)
{
    LRESULT ret = 0;

    switch (nMsg)
    {
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    
    default:
        ret = DefWindowProc(hWnd, nMsg, wParam, lParam);
        break;
    }

    return ret;
}
