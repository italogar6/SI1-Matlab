function [pop] = OrdenaFitnessBurbuja(pop, I)

    n=size(pop);
    if(n>1)
        for i=1:n 
            for j=1:n-i 
                if pop(fitnessCarla(pop(j,:), I)) > pop(fitnessCarla(pop(j+1,:), I)) 
                    aux=pop(j,:); 
                    pop(j,:)=pop(j+1,:); 
                    pop(j+1,:)=aux; 
                end
            end
        end
    end    
end


