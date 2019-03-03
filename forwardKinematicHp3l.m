% -------------------- FORWARD_KINEMATIC_HP3L --------------------------
function [coordinate, T1, T02, T03, T04, T05, T06] = forwardKinematicHp3l(t)
	% forward_kinematic_HP3L: realiza o calculo da Cinematica Direta do Motoman HP3L.
	%
	% É baseada no uso de transformacoes homogeneas de cada juntas, em que foram
	% obtidas por meio dos parâmetros de Denavit-Hartenberg do manipulator em questao.
	% Sendo a multiplicacao dessas transformacoes, isto é, T = T1*T2*T3*T4*T5*T6,
	% a Cinematica Direta. Onde, por meio de T, obtem-se os valores das coordenadas
	% cartesianas do efetuador, isto é, (x, y, z).

	% obs: t are the angles in degrees.
	% Constants of manipulator HP3L.
	d1 = 300; a2 = 100; a3 = 370; a4 = 85;
	d2 = 170; d4 = 191.5; d5 = 380-d4; d6 = 90;

	T1 = zeros(4); T2 = zeros(4); T3 = zeros(4);
	T4 = zeros(4); T5 = zeros(4); T6 = zeros(4);

	T1=[cosd(t(1))   -sind(t(1))   0  0;
	    sind(t(1))    cosd(t(1))   0  0;
	     0              0          1  d1;
	     0              0          0  1];

	T2=[sind(t(2))    cosd(t(2))     0   a2;
	     0              0            1   d2;
	    cosd(t(2))    -sind(t(2))    0   0;
	     0              0            0   1];

	T3=[cosd(t(3))    -sind(t(3))    0   a3;
	    -sind(t(3))   -cosd(t(3))    0   0;
	     0              0           -1   0;
	     0              0            0   1];

	T4=[cosd(t(4))    sind(t(4))     0   a4;
	     0              0           -1  -d4;
	   -sind(t(4))   cosd(t(4))      0   d2;
	     0              0            0   1];

	T5=[cosd(t(5))    -sind(t(5))    0   0;
	     0              0            1   0;
	    -sind(t(5))   -cosd(t(5))    0   d5;
	     0              0            0   1];

	T6=[cosd(t(6))    -sind(t(6))    0   0;
	     0              0           -1  -d6;
	    sind(t(6))    cosd(t(6))     0   0;
	     0              0            0   1];

	T02 = T1*T2;  T03 = T02*T3; T04 = T03*T4;
	T05 = T04*T5; T06 = T05*T6;

	coordinate = [round(T06(1,4)), round(T06(2,4)), round(T06(3,4))];

end
