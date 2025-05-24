% weooewpopewo
input(INPUT_LIST):-
list_to_set(INPUT_LIST,WORK_LIST),
conglutination(WORK_LIST,RETURN_LIST),
output(RETURN_LIST)
.	

% ������� ������
output(RETURN_LIST) :-
length(RETURN_LIST, LenRL),LenRL=\=0,
nth0(0,RETURN_LIST,Elem),
delete(RETURN_LIST,Elem,New_Out_List),
output(New_Out_List) ;
write(". End")
.

conglutination(W_L,R_L) :-
length(W_L,WL_Len),
WL_Len =\= 0,
(
	nth0(0,W_L,Cur_Elem),
	delete(W_L,Cur_Elem,N_W_L),
	compare_element(N_W_L,Cur_Elem,Result),
	list_to_set(Result,ResultSet),
	length(Result,Result_Len),
		(
			Result_Len =\= 0,
			conglutination(N_W_L,ResultSet)
			;
			appends(Cur_Elem,R_L,R_L),
			conglutination(N_W_L,ResultSet)
		)
)
.

compare_element(W_L,Cur_Elem,Result):-
length(W_L,WL_Len),
WL_Len =\= 0,
(
	nth0(0,W_L,Next_Elem),
	delete(W_L,Next_Elem,E_L),
	intersection(Cur_Elem,Next_Elem,IntersectionList),
	length(Cur_Elem,Cur_Len),
	length(IntersectionList,IL_Len),
	IL_Len is Cur_Len-1,
	appends(IntersectionList,Result),
	compare_element(E_L,Cur_Elem,Result)
	;
	compare_element(W_L,Cur_Elem,Result)
)
.

