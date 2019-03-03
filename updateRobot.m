%%
% function pts = updateRobot()
%
% Author: Nuno Ferreira and Nadia R. M. Oliveira
% Date:   01 July 2018
% Course: Electrical Engineering
%
% Function   : UpdateRobot
%
% Description: Update of the configurations (positions of the joints)
%							 of the manipulator and model 3D.
%
% Parameters : anglesCurrent - an array with current values of the joints
%              coordCurrent  - an array with current values of the
%															 cartesian coordinates of the end-effector
%							 coordOld			 - an array with last values of the
%															 cartesian coordinates of the end-effector
%
% Return     : coordCurrent - update after to call forward_kinematic_HP3L.
%							 coordOld -
%
function [coordCurrent, coordOld] = updateRobot(anglesCurrent, coordCurrent, coordOld, bitMoveManipulator)

	global T01 T02 T03 T04 T05 T06
	global T01old T02old T03old T04old T05old T06old
	global links

	coordOld = coordCurrent;
	[coordCurrent, T01, T02, T03, T04, T05, T06] = forwardKinematicHp3l(anglesCurrent);

	if (bitMoveManipulator)
		j = 1; k = 0; old = 0;
	  while (j ~= 7)
	      if (j == 1)
	          peca = links(1); T1 = T01old^-1; T2 = T01;
	      elseif (j == 2)
	          peca = links(2); T1 = T02old^-1; T2 = T02;
	      elseif (j == 3)
	          peca = links(3); T1 = T03old^-1; T2 = T03;
	      elseif (j == 4)
	          peca = links(4); T1 = T04old^-1; T2 = T04;
	      elseif (j == 5)
	          peca = links(5); T1 = T05old^-1; T2 = T05;
	      elseif (j == 6)
	          peca = links(6); T1 = T06old^-1; T2 = T06;
	      end

	      % sï¿½ processa a partir do angulo alterado em comparaï¿½ao com
	      % a ultima alteraï¿½ao
	      if (old == 0)
	        if (T1^-1 == T2) % quando ocorrer, nao houve alteracao do angulo.
	            j = j + 1;
	        else
	            old = 1;
	        end
	      elseif (old == 1)
	          X = get(peca, 'XData'); x1 = X(1,:);
	          if size(X,1) == 3
	              x2 = X(2,:); x3 = X(3,:);
	          end

	          Y = get(peca, 'YData'); y1 = Y(1,:);
	          if size(Y,1) == 3
	              y2 = Y(2,:); y3 = Y(3,:);
	          end

	          Z = get(peca, 'ZData'); z1 = Z(1,:);
	          if size(Z,1) == 3
	              z2 = Z(2,:); z3 = Z(3,:);
	          end
	          if size(X,1) == 1
	              objecto=[x1; y1; z1; ones(1,size(x1,2))];
	              if k == 0
	                  final = T1*objecto;
	              elseif k == 1
	                  final = T2*objecto;
	              end
	              set(peca, 'XData', [final(1,1:size(x1,2))]);
	              set(peca, 'YData', [final(2,1:size(x1,2))]);
	              set(peca, 'ZData', [final(3,1:size(x1,2))]);
	          end
	          if size(X,1) == 3
	              objecto = [x1 x2 x3; y1 y2 y3; ...
	                         z1 z2 z3; ones(1,3*size(x1,2))];
	              if k == 0
	                  final = T1*objecto;
	              elseif k == 1
	                  final = T2*objecto;
	              end
	              set(peca,'XData',[final(1, 1:size(x1, 2)); ...
	                                final(1, size(x1, 2)+1:2*size(x1, 2)); ...
	                                final(1, 2*size(x1, 2)+1:3*size(x1, 2))]);
	              set(peca,'YData',[final(2, 1:size(x1, 2)); ...
	                                final(2, size(x1, 2)+1:2*size(x1, 2)); ...
	                                final(2, 2*size(x1, 2)+1:3*size(x1, 2))]);
	              set(peca,'ZData',[final(3, 1:size(x1, 2)); ...
	                                final(3, size(x1, 2)+1:2*size(x1, 2)); ...
	                                final(3, 2*size(x1, 2)+1:3*size(x1, 2))]);
	          end
	          if (j == 1)
	              links(1) = peca;
	          elseif (j == 2)
	              links(2) = peca;
	          elseif (j == 3)
	              links(3) = peca;
	          elseif (j == 4)
	              links(4) = peca;
	          elseif (j == 5)
	              links(5) = peca;
	          elseif (j == 6)
	              links(6) = peca;
	          end

	          k = k + 1;
	          if (k == 2)
	              j = j + 1; k = 0;
	          end
	      end
	  end
	drawnow;
	T01old = T01; T02old = T02; T03old = T03;
	T04old = T04; T05old = T05; T06old = T06;
	end
end
