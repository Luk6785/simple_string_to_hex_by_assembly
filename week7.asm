.386
.model flat,stdcall
option casemap:none

WinMain proto :DWORD,:DWORD,:DWORD,:DWORD

include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
;include \masm32\include\masm32rt.inc 

includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib

.data
ClassName db "Text",0
AppName  db "Our First Window",0
MenuName db "FirstMenu",0
ButtonClassName db "button",0
ButtonText db "My First Button",0
EditClassName db "edit",0
TestString db "Wow! I'm in an edit box now",0
i dd 0  

.data?          
mSize dd ?
hInstance HINSTANCE ?
CommandLine LPSTR ?
hwndButton HWND ?
hwndEdit HWND ?
buffer db 512 dup(?)   ; buffer to store the text retrieved from the edit box
mStr db 512 dup(?)  
Value dd ?                

.const

ButtonID equ 1                                ; The control ID of the button control
EditID equ 2                                    ; The control ID of the edit control
IDM_HELLO equ 1
IDM_CLEAR equ 2
IDM_GETTEXT equ 3
IDM_EXIT equ 4

.code

start:
    invoke GetModuleHandle, NULL
    mov    hInstance,eax
    invoke GetCommandLine
    mov CommandLine,eax
    invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT
    invoke ExitProcess,eax

WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD
    LOCAL wc:WNDCLASSEX
    LOCAL msg:MSG
    LOCAL hwnd:HWND
    mov   wc.cbSize,SIZEOF WNDCLASSEX
    mov   wc.style, CS_HREDRAW or CS_VREDRAW
    mov   wc.lpfnWndProc, OFFSET WndProc
    mov   wc.cbClsExtra,NULL
    mov   wc.cbWndExtra,NULL
    push  hInst
    pop   wc.hInstance
    mov   wc.hbrBackground,COLOR_BTNFACE+1
    mov   wc.lpszMenuName,OFFSET MenuName
    mov   wc.lpszClassName,OFFSET ClassName
    invoke LoadIcon,NULL,IDI_APPLICATION
    mov   wc.hIcon,eax
    mov   wc.hIconSm,eax
    invoke LoadCursor,NULL,IDC_ARROW
    mov   wc.hCursor,eax
    invoke RegisterClassEx, addr wc
    invoke CreateWindowEx,WS_EX_CLIENTEDGE,ADDR ClassName, \
                        ADDR AppName, WS_OVERLAPPEDWINDOW,\
                        CW_USEDEFAULT, CW_USEDEFAULT,\
                        300,200,NULL,NULL, hInst,NULL
    mov   hwnd,eax
    invoke ShowWindow, hwnd,SW_SHOWNORMAL
    invoke UpdateWindow, hwnd
    .WHILE TRUE
        invoke GetMessage, ADDR msg,NULL,0,0
        .BREAK .IF (!eax)
        invoke TranslateMessage, ADDR msg
        invoke DispatchMessage, ADDR msg
    .ENDW
    mov     eax,msg.wParam
    ret
WinMain endp

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    .IF uMsg==WM_DESTROY
        invoke PostQuitMessage,NULL
    .ELSEIF uMsg==WM_CREATE
        invoke CreateWindowEx,WS_EX_CLIENTEDGE, ADDR EditClassName,NULL,\
                        WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT or\
                        ES_AUTOHSCROLL,\
                        50,35,200,25,hWnd,8,hInstance,NULL
        mov  hwndEdit,eax
        invoke SetFocus, hwndEdit
        invoke CreateWindowEx,NULL, ADDR ButtonClassName,ADDR ButtonText,\
                        WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON,\
                        75,70,140,25,hWnd,ButtonID,hInstance,NULL
        mov  hwndButton,eax
    .ELSEIF uMsg==WM_COMMAND
        mov eax,wParam
        .IF lParam==0
            .IF ax==IDM_HELLO
                invoke SetWindowText,hwndEdit,ADDR TestString
            .ELSEIF ax==IDM_CLEAR
                invoke SetWindowText,hwndEdit,NULL
            .ELSEIF  ax==IDM_GETTEXT
                 invoke GetWindowText,hwndEdit,ADDR buffer,512
               
              
                mov i,0 
                xor eax,eax
                invoke lstrlen, addr buffer
                mov mSize,eax
                mov edx,mSize
                mov esi, OFFSET buffer
                
                .WHILE i != edx
                    push edx
                    xor ebx,ebx
                    mov bl, [esi]
                    add esi,1
                    mov Value, (ebx)
                    .IF Value == 'A'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '1'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'B'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'C'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'D'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'E'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'F'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'G'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'H'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '8'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'I'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '9'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'J'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'A'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'K'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'B'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'L'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'C'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'M'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'D'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'N'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'E'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'O'
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'F'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'P'
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '0'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'Q'
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '1'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'R'
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'S'
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'T'
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'U'
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'V'
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'W'
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'X'
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '8'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'Y'
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '9'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'Z'
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'A'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    

                    .ELSEIF Value == 'a'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '1'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'b'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'c'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'd'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'e'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'f'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'g'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'h'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '8'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'i'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '9'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'j'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'A'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'k'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'B'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'l'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'C'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'm'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'D'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'n'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'E'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'o'
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'F'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'p'
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '0'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'q'
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '1'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'r'
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 's'
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 't'
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'u'
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'v'
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'w'
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'x'
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '8'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'y'
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '9'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 'z'
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'A'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value



                    .ELSEIF Value == '0'
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '0'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '1'
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '1'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '2'
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '3'
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '4'
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '5'
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '6'
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '7'
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '8'
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '8'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '9'
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '9'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value



                    .ELSEIF Value == 21h
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '1'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 22h
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 23h
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '3'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 24h
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '4'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 25h
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 26h
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '6'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 27h
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '7'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 28h
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '8'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == 29h
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '9'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value

                    .ELSEIF Value == 20h
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, '0'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '*'
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'A'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '+'
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'B'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == ','
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'C'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '-'
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'D'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '.'
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'E'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '/'
                        mov Value, '2'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'F'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value
                    .ELSEIF Value == '\'
                        mov Value, '5'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 'C'
                        invoke lstrcat, ADDR mStr, ADDR Value
                        mov Value, 20h
                        invoke lstrcat, ADDR mStr, ADDR Value



                    .ENDIF 
                    inc i
                    pop edx
                .ENDW
                  
                  invoke MessageBox,NULL,ADDR mStr,ADDR AppName,MB_OK
                  mov mStr,00h
                  mov i,0d
                  mov buffer,00h
                
            .ELSE
                invoke DestroyWindow,hWnd
            .ENDIF
        .ELSE
            .IF ax==ButtonID
                shr eax,16
                .IF ax==BN_CLICKED
                    
                    invoke SendMessage,hWnd,WM_COMMAND,IDM_GETTEXT,0
                   
                .ENDIF
            .ENDIF
        .ENDIF
    .ELSE
        invoke DefWindowProc,hWnd,uMsg,wParam,lParam
        ret
    .ENDIF
     xor    eax,eax
    ret
WndProc endp
end start 