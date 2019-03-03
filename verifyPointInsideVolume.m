function output = verifyPointInsideVolume(pointAnalyzed, pointsObst, sizeObst, offset)

  output = 0; % output = zeros(1, 3); distance = [];
  k = zeros(1, 6);

  for i = 1 : size(pointsObst, 1)

    k(3) = offset(3) + sizeObst(i, 3);
    k(2) = offset(2) + sizeObst(i, 2);
    k(1) = offset(1) + sizeObst(i, 1);

    %distance(i, 1) = pdist([[pointsObst(i, 1) - k(1), ...
    %                         pointsObst(i, 2) - k(3), ...
    %                         pointsObst(i, 3) - k(5)]; ...
    %                         pointAnalyzed], 'euclidean');
    %distance(i, 2) = pdist([[pointsObst(i, 1) - k(2), ...
    %                         pointsObst(i, 2) - k(4), ...
    %                         pointsObst(i, 3) - k(6)]; ...
    %                         pointAnalyzed], 'euclidean');
    %hold on;
    %plot3([(pointsObst(i, 1) - k(1)); (pointsObst(i, 1) + k(1))], ...
    %      [(pointsObst(i, 2) - k(2)); (pointsObst(i, 2) + k(2))], ...
    %      [(pointsObst(i, 3) - 0); (pointsObst(i, 3) + k(3))], 'g');

    %if (pointAnalyzed(1) >= (pointsObst(i, 1) - k(1))) & ...
    %   (pointAnalyzed(1) <= (pointsObst(i, 1) + k(2)))
    %    output(1) = 1;
    %end
    %if (pointAnalyzed(2) >= (pointsObst(i, 2) - k(3))) & ...
    %   (pointAnalyzed(2) <= (pointsObst(i, 2) + k(4)))
    %    output(2) = 1;
    %end
    %if (pointAnalyzed(3) >= (pointsObst(i, 3) - k(5))) & ...
    %   (pointAnalyzed(3) <= (pointsObst(i, 3) + k(6)))
    %    output(3) = 1;
    %end
    %bit = 0;
    %if (isequal(output, [1 1 1]))
    %  bit = 1; break;
    %end

    if ((pointAnalyzed(1) >= (pointsObst(i, 1) - k(1)))) & ...
        (pointAnalyzed(1) <= (pointsObst(i, 1) + k(1))) & ...
       ((pointAnalyzed(2) >= (pointsObst(i, 2) - k(2)))) & ...
        (pointAnalyzed(2) <= (pointsObst(i, 2) + k(2))) & ...
       ((pointAnalyzed(3) >= (pointsObst(i, 3) - 0    )) & ...
        (pointAnalyzed(3) <= (pointsObst(i, 3) + k(3))))
          output = 1; break;
    else
      output = 0;
    end
  end

end
