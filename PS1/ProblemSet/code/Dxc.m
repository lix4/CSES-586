% forward difference
function d = Dxc(u)
d = (DxF(u)+DxB(u))/2;
end