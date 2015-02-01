function s =  backtracking(f,grad,hess,x,d,c1,c2)

s=1;

while (feval(f,x+s*d)>feval(f,x)+c1*s*feval(grad,x)'*d)
	s = 0.3*s;
end  


