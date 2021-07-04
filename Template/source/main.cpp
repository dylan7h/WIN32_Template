#include <assert.h>
#include "WndMain.h"

LPCTSTR lpszClassName = _T("WIN32");
LPCTSTR lpszTitleName = _T("WIN32");

int APIENTRY _tWinMain(HINSTANCE hInstance, HINSTANCE hPreInstance, LPTSTR lpszCmdParam, int nCmdShow)
{
    int ret;

    (void)hPreInstance;
    (void)lpszCmdParam;

    CWndMain* pInstance = CWndMain::GetInstance(hInstance, lpszClassName, lpszTitleName);
    assert(pInstance != nullptr);

    pInstance->ShowWindow(nCmdShow);
    ret = pInstance->Exec();

    CWndMain::Release();
    pInstance = nullptr;

    return ret;
}

