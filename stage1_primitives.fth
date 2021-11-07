:! POSTPONE  NAME FIND COMPILE ;
:! :  POSTPONE :! POSTPONE DOCOL ;

: THERE  RDI RAXXCHGQ  ;
: ALLOT  RDI RAX ADDQ  DROP ;
: 1ALLOT  RDI INCQ ;

: 1+  RAX INCQ ;

: COND  RBX RAX MOVQ  DROP  RBX RBX TESTQ ;

:! BEGIN  HERE ;
:! AHEAD  HERE 1+  HERE POSTPONE JMP$ ;
:! IF  POSTPONE COND  HERE 1+  HERE POSTPONE JZ$ ;
:! AGAIN  POSTPONE JMP$ ;
:! UNTIL  POSTPONE COND POSTPONE JZ$ ;
:! THEN  THERE  DUP REL8,  THERE DROP ;
:! ELSE  POSTPONE AHEAD  SWAP  POSTPONE THEN ;

: EXECUTE   RBX RAX MOVQ  DROP  RBX JMP
:! [  RDI PUSHQ  BEGIN NAME FIND EXECUTE AGAIN
:! ]  POSTPONE ;  RBX POPQ  RDI POPQ  RDI JMP

: C@  RAX RAX MOVZXB@ ;
: C!  RAX RDX MOVB!  DROP DROP ;

: 1+  RAX INCQ ;
: 1-  RAX DECQ ;

: COUNT  1+ DUP 1- C@ ;

: >R  RBX POPQ  RAX PUSHQ  RBX PUSHQ  DROP ;
: R>  DUP  RBX POPQ  RAX POPQ  RBX PUSHQ ;
: RDROP  RBX POPQ  RSP [ $ 8 ] ADDQ$  RBX PUSHQ ;

: CONTEXT>R  RBX POPQ   RCX PUSHQ RSI PUSHQ RDI PUSHQ  RBX PUSHQ ;
: R>CONTEXT  RBX POPQ   RDI POPQ  RSI POPQ  RCX POPQ   RBX PUSHQ ;

: MOVE  CONTEXT>R  RDI RAX MOVQ DROP  RCX RAX MOVQ DROP  RSI RAX MOVQ  REP MOVSB
        RAX RDI MOVQ  R>CONTEXT  RDI RAX MOVQ  DROP ;

: INLINE  R> COUNT HERE MOVE ;
:! {  POSTPONE INLINE  HERE  1ALLOT ;
:! }  DUP 1+  HERE SWAP -  SWAP C! ;


INT3!

:! 1+ { RAX INCQ }
INT3!

: TEST  $ 40 IF DUP TX ELSE 1+ DUP TX THEN ;
INT3!

[ TEST BYE ]