function [] =print_f(n)

fout=fopen('../f.txt','w');

% Print the non-linear Fourier rapresentation of the non
% linear term F(z)=-z*z_x in the Burger Equation

s=sprint_da0(n);
fprintf(fout,'f_a0\t -0.5*d(%s,x)\n',s);

for k=1:n
    s=sprint_dak(k,n);
    fprintf(fout,'f_a%d\t -0.5*d(%s,x)*(N>%d)\n',k,s,k-1);
    s=sprint_dbk(k,n);
    fprintf(fout,'f_b%d\t -0.5*d(%s,x)*(N>%d)\n',k,s,k-1);
end

% Print the Fourier coeficients of the specific disturbance 
% in example 4.5 with d=M2+A2*sin(alpha*t) 
fprintf(fout,'d_a0\t 2*M2\n');
if n>0
    fprintf(fout,'d_a1\t 0*(N>0)\n');
    fprintf(fout,'d_b1\t A2*(N>0)\n');
end
for k=2:n
    fprintf(fout,'d_a%d\t 0*(N>%d)\n',k,k-1);
    fprintf(fout,'d_b%d\t 0*(N>%d)\n',k,k-1);
end
fprintf(fout,'d\t M2+A2*sin(alpha2*t)\n');


% Print Gamma for the example 4.5 with yr=M1+A1*sin(2*alpha*t) 

fprintf(fout,'Gamma_a0\t (2*M1-C(at0))/G\n');
if n>0
    fprintf(fout,'Gamma_a1\t (0-C(at1))/G*(N>0)\n');
    fprintf(fout,'Gamma_b1\t (0-C(bt1))/G*(N>0)\n');
end
if n>1
    fprintf(fout,'Gamma_a2\t (0-C(at2))/G*(N>1)\n');
    fprintf(fout,'Gamma_b2\t (A1-C(bt2))/G*(N>1)\n');
end
for k=3:n
    fprintf(fout,'Gamma_a%d\t (0-C(at%d))/G*(N>%d)\n',k,k,k-1);
    fprintf(fout,'Gamma_b%d\t (0-C(bt%d))/G*(N>%d)\n',k,k,k-1);
end
s=sprintf('u\t0.5*Gamma_a0');
for k=1:n
    s0=s;
    s=sprintf('%s+Gamma_a%d*cos(alpha*%d*t)+Gamma_b%d*sin(alpha*%d*t)',s0,k,k,k,k);
 end
fprintf(fout,'%s\n',s);

fprintf(fout,'yr\t M1+A1*sin(alpha1*t)\n');

end

