%%
% function pts = getPointsLinksManipulator()
%
% Author: Nadia R. M. Oliveira  (nadiamatos.18@gmail.com)
% Date:   01 July 2018
% Course: Electrical Engineering
%
% Function   : GetPointsLinksManipulator
%
% Description: Function returns a series of spaced dots that are in
%              the links of the handler
%
% Parameters : without parametros
%
% Return     : pts - an array with the points of the links of
%              manipulator in question.
%
function pts = getPointsLinksManipulator()

  global T01 T02 T03 T04 T05 T06

  x(5) = T06(1, 4); y(5) = T06(2, 4); z(5) = T06(3, 4);
  x(1) = T02(1, 4); y(1) = T02(2, 4); z(1) = T02(3, 4);
  x(2) = T03(1, 4); y(2) = T03(2, 4); z(2) = T03(3, 4);
  x(3) = T04(1, 4)-70; y(3) = T04(2, 4); z(3) = T04(3, 4);
  x(4) = T05(1, 4); y(4) = T05(2, 4); z(4) = T05(3, 4);

  a1 = interpolation([x(1) y(1) z(1)], [x(2) y(2) z(2)]);
  a2 = interpolation([x(2) y(2) z(2)], [x(3) y(3) z(3)]);
  a3 = interpolation([x(3) y(3) z(3)], [x(4) y(4) z(4)]);
  a4 = interpolation([x(4) y(4) z(4)], [x(5) y(5) z(5)]);
  pts = [];

  for i = 1 : size(a1, 1)
    pts(end+1:end+24, :) = computesPointNeighborhood(a1(i, :), [50, 80, 50]);
    pts(end+1:end+24, :) = computesPointNeighborhood(a2(i, :), [50, 80, 50]);
    pts(end+1:end+24, :) = computesPointNeighborhood(a3(i, :), [50, 80, 50]);
    pts(end+1:end+24, :) = computesPointNeighborhood(a4(i, :), [50, 80, 50]);
  end

  %hold on;
  %plot3(pts(:, 1), pts(:, 2), pts(:, 3), '*g', 'LineWidth', 2);

end
