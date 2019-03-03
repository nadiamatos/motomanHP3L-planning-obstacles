% based in http://www.gabrielgambetta.com/astar-demystified.html

function pointsOfTrajectory = aStar(pointStart, pointEnd, pointsObst, ...
									mesuareObst, mesuareTarget, coordCurrent, ...
									anglesCurrent)

	offsetAxi = [50, 50, 50]; distance = 0; iterations = 0;
	minDistEndPoint = 100; indexNode = 0; pts = []; ptsManipulator = [];
	offsetAxiObst = [50, 50, 0]; coordOld = coordCurrent; coord = coordOld;
	distance = 0; cost = 0;
	reachable = struct('nodeCurrent', pointStart, ...
					   'nodePrevious', pointStart, 'cost', 0);
	explored = reachable; node = reachable; pointsOfTrajectory = [];
	hold on; bitEmptyReached = 0;

	while (~bitEmptyReached)
		bitEmptyReached = isempty(reachable);
		try
			[node, indexNode] = chooseNode(reachable, pointEnd);
		catch
			pointsOfTrajectory = []; disp('Trajetoria NAO Encontrada');
			break;
		end
		distance = pdist([node.nodeCurrent; pointEnd], 'euclidean');
		if (distance <= minDistEndPoint)
			pointsOfTrajectory = buildPath(explored, node);
			break;
		end

		reachable(indexNode) = []; explored(end+1) = node;
		pts = computesPointNeighborhood(node.nodeCurrent, offsetAxi);
		for i = 1 : size(pts, 1)
			if (~verifyElementsInStruct(pts(i, :), explored))
				% anglesCurrent = zeros(1, 6); cost = 0; coordCurrent = coordOld;
				% coord = coordOld;
				cost = 0; bit = 0;
				[anglesCurrent, bit] = inverseKinematicHp3l(node.nodeCurrent, pts(i, :), anglesCurrent);
				if (bit)
					cost = inf; % disp('Text');
				else
					[coordCurrent, coord] = updateRobot(anglesCurrent, coordCurrent, coord, 0);
					ptsManipulator = getPointsLinksManipulator();
					for j = size(ptsManipulator, 1) : -1 : 1
						bit = verifyPointInsideVolume(ptsManipulator(j, :), pointsObst, ...
													  mesuareObst, offsetAxiObst);
						if (bit) cost = inf; break; end
					end
				end
				newReachable(i) = struct('nodeCurrent', pts(i, :), ...
										 'nodePrevious', node.nodeCurrent, ...
										 'cost', cost);
		  end
		end

		for i = 1 : size(newReachable, 2)
			adjacent = newReachable(i);
			[bit, ~] = verifyElementsInStruct(adjacent.nodeCurrent, reachable);
			if (~bit) reachable(end+1) = adjacent; end
			if ((node.cost + max(offsetAxi)) < adjacent.cost)
				adjacent.nodePrevious = node.nodeCurrent;
				adjacent.cost = node.cost + max(offsetAxi);
			end

		end
		iterations = iterations + 1;
		% if (isequal(1, iterations)) newReachable(1) = []; end
		plot3(pts(:, 1), pts(:, 2), pts(:, 3), '*r');
		%plot3(node.nodeCurrent(1), node.nodeCurrent(2), node.nodeCurrent(3), '*g');
		drawnow;
	end

end

function [bestNode, indexNode] = chooseNode(reachable, pointEnd)

	minCost = 100000000; bestNode = []; indexDeletar = [];
	totalCost = 0; costStartToNode = 0; costNodeToGoal = 0;

	for i = 1 : size(reachable, 2)
		if ~isequal(reachable(i).cost, inf)
			costStartToNode = pdist([reachable(i).nodeCurrent; ...
												reachable(i).nodePrevious], 'euclidean');
			costNodeToGoal = pdist([reachable(i).nodeCurrent; pointEnd], 'euclidean');
			totalCost = costStartToNode + costNodeToGoal;
			reachable(i).cost = totalCost;
			if (minCost > totalCost)
				minCost = totalCost; bestNode = reachable(i); indexNode = i;
			end
		end
	end

end

function pathFound = buildPath(explored, node)

	pathFound = []; bitIsMemberOfStruct = 1;

	for i = 1 : size(explored, 2)
		pathFound(end+1, :) = node.nodeCurrent;
		[bitIsMemberOfStruct, index] = verifyElementsInStruct(node.nodePrevious, explored);
		node = explored(index);
	end

end

function [bitIsMemberOfStruct, index] = verifyElementsInStruct(element, structRequired)

	bitIsMemberOfStruct = 0; index = 0;

	for i = 1 : size(structRequired, 2)
		if (isequal(element, structRequired(i).nodeCurrent))
			bitIsMemberOfStruct = 1; index = i; break;
		end
	end

end
