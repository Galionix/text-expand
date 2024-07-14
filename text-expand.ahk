#Persistent
#NoEnv
SetBatchLines, -1

global TypedWord := ""
global FileNames := []

; Read the text files in the folder on launch
Loop, *.txt
{
    FileNames.Push(SubStr(A_LoopFileName, 1, -4)) ; Remove the .txt extension
}

; Hotstrings to capture key presses
~*a::HandleKey("a")
~*b::HandleKey("b")
~*c::HandleKey("c")
~*d::HandleKey("d")
~*e::HandleKey("e")
~*f::HandleKey("f")
~*g::HandleKey("g")
~*h::HandleKey("h")
~*i::HandleKey("i")
~*j::HandleKey("j")
~*k::HandleKey("k")
~*l::HandleKey("l")
~*m::HandleKey("m")
~*n::HandleKey("n")
~*o::HandleKey("o")
~*p::HandleKey("p")
~*q::HandleKey("q")
~*r::HandleKey("r")
~*s::HandleKey("s")
~*t::HandleKey("t")
~*u::HandleKey("u")
~*v::HandleKey("v")
~*w::HandleKey("w")
~*x::HandleKey("x")
~*y::HandleKey("y")
~*z::HandleKey("z")
~*0::HandleKey("0")
~*1::HandleKey("1")
~*2::HandleKey("2")
~*3::HandleKey("3")
~*4::HandleKey("4")
~*5::HandleKey("5")
~*6::HandleKey("6")
~*7::HandleKey("7")
~*8::HandleKey("8")
~*9::HandleKey("9")
~*-::HandleKey("-")
~*_::HandleKey("_")
~*Space::ProcessWord()

HandleKey(key) {
    global TypedWord
    if (key = "Backspace") {
        TypedWord := SubStr(TypedWord, 1, -1)
    } else {
        TypedWord .= key
    }
}

ProcessWord() {
    global TypedWord
    global FileNames

    ; Check if TypedWord matches any file name
    for each, fileName in FileNames {
        if (InStr(TypedWord, fileName)) {
            ; Read the file's contents
            filePattern := fileName ".txt"
            if (FileExist(filePattern)) {
                FileRead, fileContents, %filePattern%

                ; Overwrite the typed word with the file's contents
                Loop, % StrLen(TypedWord) + 1
                {
                    Send, {Backspace}
                }
                SendRaw, %fileContents%
            }

            ; Reset TypedWord
            TypedWord := ""
            return
        }
    }

    ; Reset TypedWord if no match found
    TypedWord := ""
}
