% forward difference
% function d = Dx(u)
% [rows,cols] = size(u);
% d = zeros(rows,cols);
% d(:,2:cols) = u(:,2:cols)-u(:,1:cols-1);
% d(:,1) = u(:,1)-u(:,cols);
% return

function d = DxF(u)
[rows,cols] = size(u);
d = zeros(rows,cols);
d(:,1:cols-1) = u(:,2:cols)-u(:,1:cols-1);
d(:,cols) = u(:,1)-u(:,cols);
end

