
function [B,J0] = xfemBmatrix1(pt,elemType,e,node1,element1)

sctr = element1(e,:);
nn   = length(sctr);
[N,dNdxi] = lagrange_basis(elemType,pt);  % element shape functions
J0 = node1(sctr,:)'*dNdxi;                % element Jacobian matrix
invJ0 = inv(J0);                          %inverse of jacobian matrix
dNdx  = dNdxi*invJ0;                      % derivatives of N w.r.t XY
Gpt = N' * node1(sctr,:);                 % Gauss point in global coord, used

% Bfem is always computed
Bfem = zeros(3,2*nn); %size of the B matrix of each element is (3*8)
Bfem(1,1:2:2*nn)  = dNdx(:,1)' ;
Bfem(2,2:2:2*nn)  = dNdx(:,2)' ;
Bfem(3,1:2:2*nn)  = (dNdx(:,2))' ;
Bfem(3,2:2:2*nn)  = (dNdx(:,1))' ;
B = Bfem;
end              % end of switch 
