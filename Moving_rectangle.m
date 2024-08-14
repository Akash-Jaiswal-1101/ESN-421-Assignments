close all;
clc;


figure;

rotateRectangle(2)

function rotateRectangle(rounds)

    h = rectangle('Position',[1 1 1 1]);
    h.EdgeColor = 'b';
    axis([0 10 0 10]);
    pause(2);
    drawnow;

    for i=1:rounds
        % Moves Up
        for y=1:0.5:8
            h.Position = [1 y 1 1];
            pause(0.1);
            drawnow;
        end

        
        % Moves Right
        for x=1:0.5:8
            h.Position = [x 8 1 1]; 
            pause(0.1);
            drawnow;
        end
        
        % Moves Down
        for y=8:-0.5:1
            h.Position = [8 y 1 1];
            pause(0.1);
            drawnow;
        end
        
        % Moves Left
        for x=8:-0.5:1
            h.Position = [x 1 1 1];
            pause(0.1);
            drawnow;
        end
    end
end



