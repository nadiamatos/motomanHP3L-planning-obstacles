% Script: animation.m
% Version of the MATLAB implemented: 2017a.
%
% Author: Nadia Matos.
% email: nadiamatos.18@gmail.com
%
% Este script realiza o planejamento de trajetória para um Manipulador
% percorrer de um ponto inicial e final a fim de desviar de obstáculos
% que possam exister entre esses dois pontos, usando o algoritmo Astar.

close all; clear all; clc;

% ----------------------- GLOBAL VARIABLES ------------------------
global T01 T02 T03 T04 T05 T06
global T01old T02old T03old T04old T05old T06old
global links

coordCurrent = zeros(1, 3); anglesCurrent = zeros(1, 6);
links = zeros(1, 6); robot = hgload('robot.dat')
coordOld = coordCurrent;

% ----------------------- SETUP OF THE 3D AMBIENT -----------------
view(120, 30); axis([-500 1200 -800 800 -100 1200]); light; grid on; rotate3d on;
set(get(gca, 'XLabel'), 'String', 'Axis - X');
set(get(gca, 'YLabel'), 'String', 'Axis - Y');
set(get(gca, 'ZLabel'), 'String', 'Axis - Z');
pointStart = [600, -600, 0]; pointEnd = [600, 550, 0];
pointsObst = [600, -180, 0; ...
						  600,  0  , 0; ...
							600,  180, 0];
heigthObst = 200; widthObst = 50; depthObst = 250;
mesuareObst = [widthObst, depthObst, heigthObst; ...
							 widthObst, depthObst, heigthObst; ...
							 widthObst, depthObst, heigthObst];
mesuareObjectPointStartandEnd = [50, 50, 0];

inclusionObject3D('k', mesuareObst(1, :), pointsObst(1, :));
inclusionObject3D('k', mesuareObst(2, :), pointsObst(2, :));
inclusionObject3D('k', mesuareObst(3, :), pointsObst(3, :));
inclusionObject3D('r', mesuareObjectPointStartandEnd, pointStart);
inclusionObject3D('c', mesuareObjectPointStartandEnd, pointEnd);

for i = 1 : 6
	links(i) = findobj('Tag', ['peca' num2str(i)]);
end

[coordOld, T01, T02, T03, T04, T05, T06] = forwardKinematicHp3l(anglesCurrent);
T01old = T01; T02old = T02; T03old = T03;
T04old = T04; T05old = T05; T06old = T06;
anglesOld = anglesCurrent; coordOld = coordCurrent;

% **************************** MAIN *******************************
[coordCurrent, coordOld] = updateRobot(anglesCurrent, coordCurrent, coordOld, 1);
pointsOfTrajectory = aStar(pointStart, pointEnd, pointsObst, ...
													 mesuareObst, mesuareObjectPointStartandEnd, ...
													 coordCurrent, anglesCurrent);
[coordCurrent, coordOld] = updateRobot(anglesCurrent, coordCurrent, coordOld, 1);
%pointsOfTrajectory = [];
if ~(isempty(pointsOfTrajectory))
	hold on;
	disp('Trajetoria Encontrada');
	plot3 (pointsOfTrajectory(:, 1), pointsOfTrajectory(:, 2), ...
				 pointsOfTrajectory(:, 3), 'b', 'LineWidth', 2);
				% for j = 1 : 1
	while true
		disp('Percorrendo Trajetoria ...');
		for i = 1 : size(pointsOfTrajectory, 1)
			[anglesCurrent, ~] = inverseKinematicHp3l(coordCurrent, ...
																					 		  pointsOfTrajectory(i, :), ...
																					      anglesCurrent);
			[coordCurrent, coordOld] = updateRobot(anglesCurrent, ...
																						 pointsOfTrajectory(i, :), ...
																						 coordCurrent, 1);
		end
		for i = size(pointsOfTrajectory, 1) : -1 :1
			[anglesCurrent, ~] = inverseKinematicHp3l(coordCurrent, ...
																					      pointsOfTrajectory(i, :), ...
																					      anglesCurrent);
			[coordCurrent, coordOld] = updateRobot(anglesCurrent, ...
																						 pointsOfTrajectory(i, :), ...
																						 coordCurrent, 1);
		end
	end

end
%getPointsLinksManipulator();
% *****************************************************************
