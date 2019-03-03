%%
% function pts = interpolation()
%
% Author: Nadia R. M. Oliveira  (nadiamatos.18@gmail.com)
% Date:   01 July 2018
% Course: Electrical Engineering
%
% Function   : Interpolation
%
% Description: Function generates a set of points between pt_start
%              and pt_required. Based on cubic polynomial.
%
% Parameters : ptRequired - an array with coordinates of the end point
%              ptStart    - an array with coordinates of the start point
%
% Return     : ptTrajectory - a matrix with the interpolated points
%                              between start and end point.
%
function ptTrajectory = interpolation(ptRequired, ptStart)
  tf = 3; % 3 seconds
  t = 1 : tf; a0 = ptStart;
	a2 = (3*(ptRequired - ptStart))/(tf^2);
  a3 = (-2*(ptRequired - ptStart))/(tf^3);

  ptTrajectory(:, 3) = a0(3) + a2(3)*(t.^2) + a3(3)*(t.^3);
  ptTrajectory(:, 2) = a0(2) + a2(2)*(t.^2) + a3(2)*(t.^3);
  ptTrajectory(:, 1) = a0(1) + a2(1)*(t.^2) + a3(1)*(t.^3);

end
