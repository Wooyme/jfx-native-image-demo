#include <windows.h>
#include <iostream>

typedef int (__stdcall *f_funci)(int);

int WINAPI wWinMain(HINSTANCE hInstance, HINSTANCE, PWSTR pCmdLine, int nCmdShow)
{

    HINSTANCE hGetProcIDDLL = LoadLibrary("client.dll");

    if (!hGetProcIDDLL) {
      return EXIT_FAILURE;
    }

    // resolve function address here
    f_funci funci = (f_funci)GetProcAddress(hGetProcIDDLL, "IsolateEnterStub_JavaMainWrapper_run_5087f5482cc9a6abc971913ece43acb471d2631b_a61fe6c26e84dd4037e4629852b5488bfcc16e7e");
    if (!funci) {
      return EXIT_FAILURE;
    }
    funci(1);
    return 0;
}


