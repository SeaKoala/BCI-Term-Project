function QvaluesStar = build_optimal_policy(gridsize, targetPosition, constants)

    
    QvaluesStar = zeros(gridsize(1), gridsize(2), constants.NUM_ACTIONS.value);
    
    %Up
    q = zeros(gridsize(1),gridsize(2));
    q(1:targetPosition(1)-1,1:end) = -1;
    q(targetPosition(1)+1:end,1:end) = +1;
    q(targetPosition(1),1:end) = -1;
    q(targetPosition(1), targetPosition(2)) = -1;
    QvaluesStar(:,:,constants.ACTION_UP.value) = q;
    

    %Down
    q = zeros(gridsize(1),gridsize(2));
    q(1:targetPosition(1)-1,1:end) = +1;
    q(targetPosition(1)+1:end,1:end) = -1;
    q(targetPosition(1),1:end) = -1;
    q(targetPosition(1), targetPosition(2)) = -1;
    QvaluesStar(:,:,constants.ACTION_DOWN.value) = q;


    %Left
    q = zeros(gridsize(1),gridsize(2));
    q(1:end,1:targetPosition(2)-1) = -1;
    q(1:end,targetPosition(2)+1:end) = +1;
    q(1:end,targetPosition(2)) = -1;
    q(targetPosition(1), targetPosition(2)) = -1;
    QvaluesStar(:,:,constants.ACTION_LEFT.value) = q;


    %Right
    q = zeros(gridsize(1),gridsize(2));
    q(1:end,1:targetPosition(2)-1) = 1;
    q(1:end,targetPosition(2)+1:end) = -1;
    q(1:end,targetPosition(2)) = -1;
    q(targetPosition(1), targetPosition(2)) = -1;
    QvaluesStar(:,:,constants.ACTION_RIGHT.value) = q;

    %End effector
    q = -1.*ones(gridsize(1),gridsize(2));
    q(targetPosition(1), targetPosition(2)) = +1;
    QvaluesStar(:,:,constants.ACTION_END_EFFECTOR.value) = q;
    
    
    
end


