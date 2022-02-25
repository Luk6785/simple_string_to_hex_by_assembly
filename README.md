# week7

I. Các thanh ghi trong kiến trúc Intel x86, x64 và ý nghĩa của chúng:
    1. General register
        a, Data register
            - Có 4 thanh ghi dữ liệu 32bit đc dùng cho số học logic và hoạt động khác theo nhiều cách :
            + Ghi dữ liệu: EAX,EBX,ECD,EDX
            + Nửa thấp của các thanh ghi 32bit có thể dùng như thanh ghi 16bit: AX,BX,CX,DX và có thể dùng như thanh ghi 8bit AH,AL,BH,BL,CH,CL,DH,DL
            . AX: là bộ phận tích lũy đầu tiên, nó dùng trong nhập xuất và hầu hết các instruction số học. Trong phép nhân, toán hạng được lưu vào EAX,AX hoặc AL tùy theo kích cỡ của toán hạng đó.
            . BX: Thanh ghi cơ sở dùng để đánh số địa chỉ
            . CX: Thanh ghi đếm được dùng như đếm số vòng lặp
            . DX: Thanh ghi dữ liệu
        b, Pointer register
            - Intruction Pointer (IP): là những thanh ghi 16nit lưu trữ địa chỉ offset của instruction tiếp theo đó thực thi. IP cùng thanh ghi CS đưa ra địa chỉ chính xác của instruction hiện tại trong code segment.
            - Stack Pointer (SP): Những thanh ghi 16 bit cung cấp giá trị offset nằm trong ngăn xếp. Chương trình SP cùng với thanh ghi SS tham chiếu đến vị trí hiện tại của dữ liệu hoặc địa chỉ nằm trong program stack.
            - Base pointer (BS): Nhưng thanh ghi 16 bit chủ yếu hỗ trợ trong việc tham chiếu biến tham số truyền tới chương trình con. Địa chỉ ghi trong thanh SS kết hợp với thanh ghi DI và SI cho địa chỉ cụ thể
        c, Index Pointer
            - Thanh ghi 32bit ESI và EDI tương ứng thanh ghi 16bit SI và DI đươch dùng để đánh số địa chỉ và dùng trong phép toán cộng trừ.
            - Source Index(SI) được dùng đánh số của nguồn cho chuỗi operations
            - Destination Index (DI) ngược lại với SI
    2. Control Register
        - Nhiều lệnh liên quan đến so sánh và tính toán toán học và thay đổi trạng thái của các cờ và một số lệnh có điều kiện khác kiểm tra giá trị của các cờ trạng thái này để đưa luồng điều khiển đến vị trí khác.
        - Các cờ phổ biến:
        a, Overflow flag(OF): tràn bit cao ngoài cùng bên trái của dữ lieuj sau 1 tín hiệu của thuật toán
        b, Direction Flag(DF): xác định hướng trái phải cho việc di chuyển hoặc so sánh chuỗi dữ liệu. Khi DF là 0 chuỗi hoạt động lấy từ trái qua phải và ngược lại
        c, Interrupt Flag(IF): cho phép thiết lập hoạt động của bộ nhớ xử lý trong chế độ đơn bước. Chương trình debug dùng thiết lập cờ mật thám vì thế từng bước thực thi tại một điểm
        d, Sign Flag(SF): hiện tín hiệu kết quả của 1 phép toán số học. Dấu hiệu địa chỉ bởi bit cao ngoài cùng bên trái. Kết quả khẳng định thiết lập giá trị SF là 0 và ngược lại là 1
        e, Carry flag(CF): xuất hiện bit nhớ bit mượn => CF = 1
        f, Zero flag (ZF): cho thấy kết quả phép toán số học hay so sánh keeys quả bằng 0 thì ZF = 1
        g, Awxilliarry Carry Flag(AF): chứa bit 3 tới bit 4 theo phép toán số học, chỉ số cụ thể phép toán.

II. Cấu trúc cơ bản của lệnh assembly trên kiến trúc Intel
    1. Các kiểu bộ nhớ : Độ lớn mã và số liệu trong một chương trình được quy định bởi chỉ dẫn MODEL
        .MODEL memory_model
    memory_model: Small, Medium, Compact, Large, Huge
    2. Đoạn số liệu: chứa các biến, khai báo hằng,..
        .DATA
        VD: 
            .DATA
            word1 DW 1
            msg DB 'This is message'
    3. Đoạn ngăn xếp: dành một vùn nhớ để lưu trữ cho stack
        .STACK size
    4. Đoạn mã: Chứa lệnh của chương trình
        .CODE
        - Bên trong đoạn mã chứa lệnh thường được tổ chức thành thủ tục mà cấu trúc của thủ tục như sau:
            name PROC
            ; body of the procedure
            name ENDP
III. Cách viết hàm và gọi tham số trong assembly trên kiến trúc Intel
    1. Produce
        - Một chương trình hợp ngữ có thể xây dựng bằng các thủ tục.
        - Cú pháp:
            name PROC type
            ; body of procedure
            RET
            name ENDP
        Trong đó:
            + name : do người dùng định nghĩa tên thủ tục
            + Type : NEAR or FAR
            + RET : trả điều kiển cho thủ tục gọi
    2. CALL và RETURN
        - Lệnh CALL được dùng để gọi một thủ tục. Có 2 cách gọi một thủ tục:
        + Gọi trực tiếp: CALL name
        + Gọi gián tiếp: CALL address-expression
        - Khi lệnh CALL đã thi hành 
        + Địa chỉ quay về của thủ tục gọi được cấp cào stack. Địa chỉ này là offset của lệnh tiếp theo lệnh CALL.
        + IP lấy địa chỉ offset của lệnh đầu tiên trên thủ tục được gọi, có nghĩa là điều khiển được chuyển đến thủ tục
        - Lệnh RET sẽ lấy giá trị trong SP đưa và IP. Nếu pop-value là một số N thì IP = SP + N . Trong cả 2 trường hợp thì CS:IP chứa địa chỉ trở về chương trình gọi và điều khiển được trả cho chương trình gọi
IV. Lập trình giao diện trong assembly trên kiến trúc Intel
    Chương trình Windows dựa trên các hàm API cho GUI (Giao diện người dùng đồ họa) của chúng ta. Đây là cách mà trước tiên nó giúp ích cho cả người sử dụng và lập trình viên. Đối với người sử dụng, ko phải học điều khiển GUI cho mỗi chương trình mới, GUI của chương trình Windows là tương tự nhau. Đối với các lập trình viên, GUI codes có sẳn đã được test và sẳn sàng cho sử dụng. Mặt trái việc này là các lập trình viên bị gia tăng sự phức tạp trong việc code. Để cài đặt hay thao tác trên bất kỳ các đối tượng GUI như là các windows, menu hay icons, lập trình viên phải theo một rule chính xác. Nhưng có thể khắc phục bằng cách modular programming hay OPP paradigm.
    1. Lấy instance handle chương trình của bạn (cần thiết)
    2. Lấy command line (ko cần thiết trừ khi chương trình muốn tiến hành 1 command line)
    3. Register (đăng ký) window class (cần thiết, trừ khi bạn dùng lọai window được định nghĩa trước. VD: Messagebox hay 1 dialog box)
    4. Cài đặt window (cần thiết)
    5. Show (hiển thị) window trên desktop ( cần thiết trừ khi bạn ko muốn show window ngay)
    6. Refesh (làm tươi) vùng client của window
    7. Enter (nhập vào) 1 vòng lặp vô hạn để kiểm tra những messages (thông điệp) từ window
    8. Nếu message xảy ra, chúng sẽ được thực thi bởi hàm chuyên trách chịu trách nhiệm của window
    9. Thoát chương trình nếu người dùng close window


.386              ; MASM sử dụng cấu trúc 80386 để set trong chương trình.
.model flat,stdcall     ; MASM model định địa chỉ theo flat memory
option casemap:none      ;báo cho trình biên dịch tuân thủ trường hợp viết hoa do người dùng chỉ định
include \masm32\include\windows.inc
include \masm32\include\user32.inc
includelib \masm32\lib\user32.lib ; calls to functions in user32.lib and kernel32.lib
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib

WinMain proto :DWORD,:DWORD,:DWORD,:DWORD

.DATA 
ClassName db "SimpleWinClass",0  
AppName db "Our First Window",0

.DATA? ; Uninitialized data
hInstance HINSTANCE ? ; chỉ số thông hành hiện tạm thời
CommandLine LPSTR ?     ; command line của chương trình

.CODE 
start:
invoke GetModuleHandle, NULL  ;gọi hàm GetModuleHandle để lấy instance handle của chương trình
mov hInstance,eax
invoke GetCommandLine 
mov CommandLine,eax
invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT ; gọi hàm WinMain
invoke ExitProcess, eax ;thoát khỏi chương trình code trả về eax của WinMain

WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD  ;khai báo hàm của WinMain
LOCAL wc:WNDCLASSEX ; tạo local variables trên stack
LOCAL msg:MSG
LOCAL hwnd:HWND

mov wc.cbSize,SIZEOF WNDCLASSEX ; fill values in members of wc
mov wc.style, CS_HREDRAW or CS_VREDRAW
mov wc.lpfnWndProc, OFFSET WndProc
mov wc.cbClsExtra,NULL
mov wc.cbWndExtra,NULL
push hInstance
pop wc.hInstance
mov wc.hbrBackground,COLOR_WINDOW+1                 ; định nghĩa những đặc trưng quan trọng riêng biệt của một window
mov wc.lpszMenuName,NULL
mov wc.lpszClassName,OFFSET ClassName
invoke LoadIcon,NULL,IDI_APPLICATION
mov wc.hIcon,eax
mov wc.hIconSm,eax
invoke LoadCursor,NULL,IDC_ARROW
mov wc.hCursor,eax
invoke RegisterClassEx, addr wc ; đăng ký window class


invoke CreateWindowEx,NULL,\
ADDR ClassName,\
ADDR AppName,\
WS_OVERLAPPEDWINDOW,\
CW_USEDEFAULT,\     
CW_USEDEFAULT,\                         ;CreateWindowEx để cài đặt window nền tảng window class đã tính toán
CW_USEDEFAULT,\
CW_USEDEFAULT,\
NULL,\
NULL,\
hInst,\
NULL
mov hwnd,eax
invoke ShowWindow, hwnd,CmdShow 
invoke UpdateWindow, hwnd 

.WHILE TRUE 
invoke GetMessage, ADDR msg,NULL,0,0
.BREAK .IF (!eax)
invoke TranslateMessage, ADDR msg       ; Hàm GetMessage sẽ ko trả về cho đến khi có một thông điệp cho một cửa sổ trong module
invoke DispatchMessage, ADDR msg        ;TranslateMessage là một hàm tiện ích bắt lấy input từ keyboard và sinh ra 1 thông điệp mới
.ENDW
mov eax,msg.wParam ; Nếu vòng lặp thông điệp kết thúc, exit code được cài nạp vào trong thành phần wParam của cấu trúc MSG
ret
WinMain endp

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
.IF uMsg==WM_DESTROY ; nếu user đóng window
invoke PostQuitMessage,NULL ; thoát
.ELSE
invoke DefWindowProc,hWnd,uMsg,wParam,lParam 
ret
.ENDIF
xor eax,eax
ret
WndProc endp

end start

