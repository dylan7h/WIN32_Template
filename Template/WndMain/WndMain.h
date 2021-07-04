#ifndef __WNDMAIN__H__
#define __WNDMAIN__H__

#include <Windows.h>
#include <tchar.h>

class CWndMain
{
    private:
        static CWndMain*        pInstance;
        static LRESULT CALLBACK WndProc(HWND hWnd, UINT nMsg, WPARAM wParam, LPARAM lParam);

    private:
        HWND       hWnd;
        HINSTANCE  hInstance;
        MSG        Message;
        WNDCLASSEX wcex;

        CWndMain(HINSTANCE hInstance, LPCTSTR lpszClass, LPCTSTR lpszTitle);
        ~CWndMain();

    public:
        static CWndMain* GetInstance(HINSTANCE hInstance, LPCTSTR lpszClass, LPCTSTR lpszTitle);
        static void      Release(void);

    public:
        void        ShowWindow(int nCmdShow);
        int         Exec(void);
};

#endif  /* !__WNDMAIN__H__ */
