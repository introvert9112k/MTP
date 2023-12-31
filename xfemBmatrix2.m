function [N2,B] = xfemBmatrix2(pt,elemType,e,node2,element2)

sctr = element2(e,:); %get the location of coordinates of current element
nn   = length(sctr);  %nn = 4
[N,dNdxi] = lagrange_basis(elemType,pt);   % element shape functions
J0 = node2(sctr,:)'*dNdxi;                 % element Jacobian matrix
invJ0 = inv(J0);
dNdx  = dNdxi*invJ0;                      % derivatives of N w.r.t XY

N2 = zeros(3,3*nn); %Matrix of size 3x12
N2(1,1:3:3*nn) = N(:,1)';
N2(2,2:3:3*nn) = N(:,1)';
N2(3,3:3:3*nn) = N(:,1)';

% Bfem is always computed
Bfem = zeros(6,3*nn);
Bfem(1,1:3:3*nn)  = dNdx(:,1)' ;
Bfem(2,1:3:3*nn)  = dNdx(:,2)' ;
Bfem(3,2:3:3*nn)  = dNdx(:,1)' ;
Bfem(4,2:3:3*nn)  = dNdx(:,2)' ;
Bfem(5,3:3:3*nn)  = dNdx(:,1)' ;
Bfem(6,3:3:3*nn)  = dNdx(:,2)' ;
B = Bfem;
end              % end of switch 