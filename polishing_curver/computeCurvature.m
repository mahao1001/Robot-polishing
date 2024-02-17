%% 计算曲率的函数
function curvature = computeCurvature(x, y)
    dx = gradient(x);
    dy = gradient(y);
    ddx = gradient(dx);
    ddy = gradient(dy);
    curvature = abs(ddx .* dy - dx .* ddy) ./ (dx.^2 + dy.^2).^(3/2);
end