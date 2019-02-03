% forward difference
function d = DyF(u)
[rows,cols] = size(u);
d = zeros(rows,cols);
d(1:rows-1,:) = u(2:rows,:)-u(1:rows-1,:);
d(rows,:) = u(1,:)-u(rows,:);
end