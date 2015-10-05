function [fit] = fitness(Pop, I) %Asumiendo valores positivos
    L = size(Pop);
    for ind=1:L(1) %Cogemos el siguiente individuo
        a = binario_a_entero (Pop(ind,1:5)) + 5;
        b = binario_a_entero (Pop(ind,6:10)) + 5;
        x0 = binario_a_entero (Pop(ind,11:16)) + 19;
        y0 = binario_a_entero (Pop(ind,17:22)) + 19;
        theta = binario_a_entero (Pop(ind,23:29));
        theta = theta*179/127; %Escalamos de 0 a 127 a 0 a 179
        theta = theta * pi/180;
        
        elipse = [];
        badElipse = false;
        for alpha=0.2:0.2:2*pi
            x = round((a*cos(alpha))*cos(theta+x0) - (b*sin(alpha)+y0)*sin(theta)+y0);
            y = round((a*cos(alpha))*sin(theta) + (b*sin(alpha)+y0)*cos(theta)+y0);
            if(x<0 || x>100 || y<0 || y>100)
                badElipse = true;
                fit(ind) = 0;
                elipse = [elipse; x y];
                break;
            end

        end
        
        %comprobamos el matching con la imagen
        if(badElipse == true)
        else
            contador = 0;
            for i=1:size(elipse,1)
                if (I(elipse(i,1),elipse(i,2))== 1) %positivo detectado
                   contador = contador+1;
                end
            end
            fit(ind) = contador/size(elipse,1);
        end
    end
end