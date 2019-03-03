%%
% function [ptsObject] = inclusionObject3D(colorObject, sizeObject, ptReferenceObject)
%
% Author: Nadia R. M. Oliveira  (nadiamatos.18@gmail.com)
% Date:   Juny 2018
% Course: Electrical Engineering
%
% Function   : InclusionObject3D
%
% Description: By means of the cube_plot function, several 3D objects are placed,
%              is in respect of starting or finishing points or objects the
%              manipulator should deflect and the points where these obstacles
%              are, are returned by this function.
%
% Parameters : colorObject  -  a character for color in Matlab.
%              sizeObject   - an array with values for height, width and depth.
%              ptReferenceObject - an array with the point where the object
%                                  will be drawn.
% Return     : ptsObject - an array with the points of the object in question.
%
% Examples of Usage:
%
%    >> inclusionObject3D('r', [10, 10, 0], [0, 0, 0])
%    ans =
%           [-5    -5     0]
%

function [ptsObject] = inclusionObject3D(colorObject, sizeObject, ptReferenceObject)

  %ptsObject = ptReferenceObject - sizeObject/2;
  ptsObject = [ptReferenceObject(1) - sizeObject(1)/2, ...
               ptReferenceObject(2) - sizeObject(2)/2, ...
               ptReferenceObject(3)];
  cubePlot(ptsObject, sizeObject(1), sizeObject(2), sizeObject(3), ...
           colorObject);
end
