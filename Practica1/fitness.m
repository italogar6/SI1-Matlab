function [fit] = fitnessCarla(Pop, I) %Asumiendo valores positivos
    L = size(Pop);
    for ind=1:L(1) %Cogemos el siguiente individuo
        a = binario_a_entero (Pop(ind,1:5)) + 5;
        b = binario_a_entero (Pop(ind,6:10)) + 5;
        x0 = binario_a_entero (Pop(ind,11:16)) + 19;
        y0 = binario_a_entero (Pop(ind,17:22)) + 19;
        theta = binario_a_entero (Pop(ind,23:29));
        theta = theta*89/127; %Escalamos de 0 a 127 a 0 a 179
        theta = theta * pi/180;
        contador = 0;
        elipse = [];
        badElipse = false;
        for alpha=0.2:0.2:2*pi
            x = round(((a*cos(alpha)).*cos(theta) - (b*sin(alpha)).*sin(theta)) +x0);
            y = round(((a*cos(alpha)).*sin(theta) + (b*sin(alpha)).*cos(theta)) +y0);
            elipse = [elipse; x y];
            if(x<=0 || x>100 || y<=0 || y>100)
                badElipse = true;
                break;
            end

        end
        
        %comprobamos el matching con la imagen
        if(badElipse == true)
            fit(ind,1) = 0;
        else

            for i=1:size(elipse,1)
                if (I(elipse(i,1),elipse(i,2))== 1) %positivo detectado
                   contador = contador+1;
                end
            end
            tam = size(elipse,1);
            fit(ind,1) = contador/tam;
        end
    end
end