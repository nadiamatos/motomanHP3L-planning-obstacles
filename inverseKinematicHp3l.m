% -------------------- INVERSE_KINEMATIC_HP3L --------------------------
function [angles_joints, bit] = inverseKinematicHp3l(pt_start, pt_required, angles_joints)
  % inverse_kinematic_HP3L: gera um conjunto angulos que o manipulator deve ter
  % entre pt_start e pt_required.
  %
  % É baseada numa matriz jacobina constituida por derivadas parciais, em funcao de
  % angulos das juntas do manipulator, das equacoes das coordenadas da Cinematica
  % Direta, isto é, (x, y, z). Essa matriz jacobina nao e quadrada, ela e (3x6).
  % Usando o conceito de pseudo-inversa, e gerada uma matriz Jm (6x6), pela qual
  % é possivel obter os deslocamentos angulares de cada junta do manipulator. Tendo-se,
  % assim, um conjunto de angulos resultantes.

	% pt_start it is a current point
	% pt_end it is a desired point

  iterations = 0; distance_pt = 1e+2;  error_dist = zeros(1, 3); alpha = 0.5;
	aux = 0; dq = []; Jm = []; bit = false;

  while ( (distance_pt > 1) )
    bit = false;
    if (iterations > 20)
      angles_joints = [0 0 0 0 0 0]; bit = true; break;
      % disp('Problema na trajetoria');
    end

    error_dist = [pt_required - pt_start]';
		Jm = jacobianHp3l(angles_joints);
    dq = alpha*Jm*error_dist;
    % update of the angles.
		for i = 1 : length(angles_joints)-1
      aux = angles_joints(i);
      angles_joints(i) = round( aux + rad2deg(dq(i, 1)) );
			% angles_joints(i) = round( aux + 180*(dq(i, 1))/pi );
		end
    [coord, ~] = forwardKinematicHp3l(angles_joints);
    distance_pt = pdist([coord; pt_start], 'euclidean');
    iterations = iterations + 1; pt_start = coord;
  end
  angles_joints = controlPositionJoints(angles_joints);
end
