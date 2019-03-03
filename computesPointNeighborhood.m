%%
% function pts = computesPointNeighborhood(ptOpenList, offsetAxi)
%
% Author: Nadia R. M. Oliveira
% Date:   01 July 2018
% Course: Electrical Engineering
%
% Function   : ComputesPointNeighborhood
%
% Description: Function generates set of points neighborhood using
%              the point ptOpenList;
%
% Parameters : ptOpenList - an array with cartesian coordinates of
%                           reference.
%              offsetAxi  - an array with value of offset for each axi
%
% Return     : pts - an array with points of neighborhood.
%
function pts = computesPointNeighborhood(ptOpenList, offsetAxi)
	x = ptOpenList(1); y = ptOpenList(2); z = ptOpenList(3);
	pts = zeros(3, 12);

	pts(:, 1)  = [x+offsetAxi(1);   y-offsetAxi(2); z];
	pts(:, 2)  = [x+offsetAxi(1);   y; 						  z];
	pts(:, 3)  = [x+offsetAxi(1);   y+offsetAxi(2); z];
	pts(:, 4)  = [x; 						    y-offsetAxi(2); z];
	pts(:, 5)  = [x; 						    y+offsetAxi(2); z];
	pts(:, 6)  = [x-offsetAxi(1);   y-offsetAxi(2); z];
	pts(:, 7)  = [x-offsetAxi(1);   y; 						  z];
	pts(:, 8)  = [x-offsetAxi(1);   y+offsetAxi(2); z];

	pts(:, 9)  = [x+offsetAxi(1);   y-offsetAxi(2);   z+offsetAxi(3)];
	pts(:, 10) = [x+offsetAxi(1);   y; 						    z+offsetAxi(3)];
	pts(:, 11) = [x+offsetAxi(1);   y+offsetAxi(2);   z+offsetAxi(3)];
  pts(:, 12) = [x; 							  y-offsetAxi(2);   z+offsetAxi(3)];
	pts(:, 13) = [x;						    y+offsetAxi(2);   z+offsetAxi(3)];
  pts(:, 14) = [x-offsetAxi(1);   y-offsetAxi(2);   z+offsetAxi(3)];
  pts(:, 15) = [x-offsetAxi(1);   y;						    z+offsetAxi(3)];
  pts(:, 16) = [x-offsetAxi(1);   y+offsetAxi(2);   z+offsetAxi(3)];

	pts(:, 17) = [x+offsetAxi(1);   y-offsetAxi(2);    z-offsetAxi(3)];
	pts(:, 18) = [x+offsetAxi(1);   y; 						    z-offsetAxi(3)];
	pts(:, 19) = [x+offsetAxi(1);   y+offsetAxi(2);    z-offsetAxi(3)];
	pts(:, 20) = [x; 							  y-offsetAxi(2);   z-offsetAxi(3)];
	pts(:, 21) = [x; 							  y+offsetAxi(2);   z-offsetAxi(3)];
	pts(:, 22) = [x-offsetAxi(1);   y-offsetAxi(2);   z-offsetAxi(3)];
	pts(:, 23) = [x-offsetAxi(1);   y; 							  z-offsetAxi(3)];
	pts(:, 24) = [x-offsetAxi(1);   y+offsetAxi(2);   z-offsetAxi(3)];

	pts = pts';
end
