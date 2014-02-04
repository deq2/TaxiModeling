%Average taxi calls on a weekend day.
function[B] =getb()
    B = zeros(20,20);
    residential = [5 11 12 14 15 16 20];
    city = [1 2 3 4 6];
    outside = [7 8 9 10 11 12 13 14 15 16 17 18 19 20];
    attractions = [10 17 18 19];

    rare = 1/(28*24*7);

    for i = 1:20
        for j = 1:20
            B(i,j) = rare;
        end
    end

    for i = 1:length(residential)
        B(7, residential(i)) = (30/ length(residential))/(60*24); %airport residential
        B(residential(i), 7) = (20/ length(residential))/(60*24); %backwards
    end

    for i = 1:length(city)
        for j = 1:length(city)
            B(i,j) = (550/(length(city))/(length(city)))/(60*24);  %city to city
        end
    end

    for i = 1:length(city)
        for j = 1:length(outside)
            B(i, j) = (75/(length(city))/(length(outside)))/(60*24);          %city to outside city
            B(j, i) = (75/(length(city))/(length(outside)))/(60*24);
        end
    end
    
    %B = .7*B;
end