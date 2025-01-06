function [axis, theta, at] = R2AT(R)
epsilon = 1e-12;
v = (trace(R) - 1) / 2;
if abs(v) < (1 - epsilon)
    theta = acos(v);
    x = 1 / (2 * sin(theta)) * (R(3, 2) - R(2, 3));
    y = 1 / (2 * sin(theta)) * (R(1, 3) - R(3, 1));
    z = 1 / (2 * sin(theta)) * (R(2, 1) - R(1, 2));
else
    if v > 0
        theta = 0;
        x = 0;
        y = 0;
        z = 0;
    else
        theta = pi;
        if (R(1, 1) >= R(2, 2)) && (R(1, 1) >= R(3, 3))
            x = sqrt((R(1, 1) + 1) / 2);
            y = R(1, 2) / (2 * x);
            z = R(1, 3) / (2 * x);
        elseif (R(2, 2) >= R(1, 1)) && (R(2, 2) >= R(3, 3))
            y = sqrt((R(2, 2) + 1) / 2);
            x = R(2, 1) / (2 * y);
            z = R(2, 3) / (2 * y);
        else
            z = sqrt((R(3, 3) + 1) / 2);
            x = R(3, 1) / (2 * z);
            y = R(3, 2) / (2 * z);
        end
    end
end
axis = [x; y; z];
at = theta * axis;