%%
% function pts = controlPositionJoints(anglesJoints)
%
% Author: Nadia R. M. Oliveira
% Date:   01 July 2018
% Course: Electrical Engineering
%
% Function   : ComputesPointNeighborhood
%
% Description: Function generates set of joints values using values
% 						 threshold.
%
% Parameters : anglesJoints - an array with joints values for to analyze.
%
% Return     : anglesJoints - an array with joints values analyzed.
%
function anglesJoints = controlPositionJoints(anglesJoints)

	upperLimitJoint = [170, 170, 235, 190, 125, 360];
	inferiorLimitJoint = [-171, -45, -144, -190, -125, -360];

	for i = 1 : length(anglesJoints)

		if ( anglesJoints(i)  > upperLimitJoint(i) )
			anglesJoints(i) = upperLimitJoint(i) - 1;
		elseif ( anglesJoints(i) < inferiorLimitJoint(i) )
			anglesJoints(i) = inferiorLimitJoint(i) + 1;
		end

	end

end
