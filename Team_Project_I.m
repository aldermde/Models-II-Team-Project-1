%Models II Team Project I
%Group:

clear all;
close all;
clc;

load Electricity_Data.mat;

val = 0;
Super_Awesome = val;
Doctor_Bucks = val;

warning('off','all'); %Disables unneeded warning messages that may appear.

while Doctor_Bucks == Super_Awesome
    
    while val == 0
        fprintf('KEEP THIS LINE HIDDEN\n');
        fprintf('Press any key to continue.\n*\n*\n');
        fprintf('NIFTY TIP: To exit the program at any time, press "ctrl + c"\n*\n*\n');
        fprintf('Please lengthen the Command Window.')
        commandwindow;
        pause
        val = 1;
        clc;
    end
        

    %Analysis Selection
    while val == 1; 
    analyzeChoice = menu('How would you like to analze the electricity data?','By Year', 'By Country', 'By Production Type','Back');
    
        if analyzeChoice == 1
            val = 10;
        elseif analyzeChoice == 2
            val = 20;
        elseif analyzeChoice == 3
            val = 30;
        elseif analyzeChoice == 4
            val = 0;
        end
    end
    %End Analysis Selection
    
    
    % Year Selection
    while val == 10
       fprintf('Please select a year from 1990 to 2011 \n \nTo go back, enter ''1''.\n\n');
       commandwindow;
       yearChoice = input('Year: ');
       clc;
       
       while isempty(yearChoice) %error catch || press enter with no number
           fprintf('Please select a year from 1990 to 2011 \n \nTo go back, enter ''1''.\n\n');
           commandwindow;
           yearChoice = input('Year: ');
           clc;
       end
       
       if yearChoice == 1 % choose to go back
          val = 1;
       end
       
       while (yearChoice > 2011 || yearChoice < 1990) && yearChoice ~= 1 %error catch || entered year out of range
           fprintf('%i is not within the desired range. \n\n',yearChoice);
           fprintf('Please select a year from 1990 to 2011 \n \nTo go back, enter ''1''.\n\n');
           commandwindow;
           yearChoice = input('Year: ');
           clc;
           while isempty(yearChoice) %error catch || press enter with no number
               fprintf('Please select a year from 1990 to 2011 \n \nTo go back, enter ''1''.\n\n');
               commandwindow;
               yearChoice = input('Year: ');
               clc;
           end
           if yearChoice == 1 % choose to go back
               val = 1;
           end
       end
    end
    %End Year Selection
    
    
    %Country Selection
    while val == 20 
        countryChoice = menu('Please select a country:', 'America', 'Australia', 'Brazil', 'Canada', 'China', 'Cuba', 'Germany', 'India', 'Japan', 'Madagascar', 'Input Other','Back');
                if countryChoice == 11 %chooses to input country
                    fprintf('Warning: Entries are case sensitive.\n\n');
                    countryChoice = input('Please input a country: ', 's');
                    while isempty(countryChoice) %Error catching || press enter too soon
                        clc;
                        fprintf('Warning: Entries are case sensitive.\n\n');
                        countryChoice = input('Please input a country: ', 's');
                    end
                    while strcmp(countryChoice, Electricity_Data.Country) == 0 %Error catching || make sure country exists
                        clc;
                        fprintf('Warning: Entries are case sensitive.\n\n');
                        fprintf('Entry of "%s" is not a valid country.\n\nPlease input a valid country:', countryChoice);
                        countryChoice = input(' ', 's');
                    end
                    clc;
                elseif countryChoice == 1
                    countryChoice = 'United States';
                elseif countryChoice == 2
                    countryChoice = 'Australia';
                elseif countryChoice == 3
                    countryChoice = 'Brazil';
                elseif countryChoice == 4
                    countryChoice = 'Canada';
                elseif countryChoice == 5
                    countryChoice = 'China';
                elseif countryChoice == 6
                    countryChoice = 'Cuba';
                elseif countryChoice == 7
                    countryChoice = 'Germany';
                elseif countryChoice == 8
                    countryChoice = 'India';
                elseif countryChoice == 9
                    countryChoice = 'Japan';
                elseif countryChoice == 10
                    countryChoice = 'Madagascar';
                elseif countryChoice == 12
                    val = 1;
                end
   %end country selection
                
       if val ~= 1 %skips plotting if user selected 'Back'
                
            %Total energy production / demand
            for k = 1990:2011
                production(k-1989) = Electricity_Data.Total_Production(find(Electricity_Data.Year == k & strcmp(Electricity_Data.Country, countryChoice) == 1));
                demand(k-1989) = Electricity_Data.Demand(find(Electricity_Data.Year == k & strcmp(Electricity_Data.Country, countryChoice) == 1));
                year(k-1989) = k;
            end

            figure;
            subplot(2,2,1);
            plot(year, production, '-b*', year, demand, '-ro');
            title('Total Energy Production and Demand by Year');
            xlabel('Year');ylabel('Energy (Million kWh)');
            legend('Energy Production', 'Energy Demand','Location','northwest','Location','southoutside');
            %end Total energy production / demand
            
            %Line graph of production types per year
            for l = 1990:2011
                productionHydro(l-1989) = Electricity_Data.Hydro_Production(find(Electricity_Data.Year == l & strcmp(Electricity_Data.Country, countryChoice) == 1));
                if productionHydro(l-1989) == -9999
                    productionHydro(l-1989) = 0;
                end
                productionSolar(l-1989) = Electricity_Data.Solar_Production(find(Electricity_Data.Year == l & strcmp(Electricity_Data.Country, countryChoice) == 1));
                if productionSolar(l-1989) == -9999
                    productionSolar(l-1989) = 0;
                end
                productionWind(l-1989) = Electricity_Data.Wind_Production(find(Electricity_Data.Year == l & strcmp(Electricity_Data.Country, countryChoice) == 1));
                if productionWind(l-1989) == -9999
                    productionWind(l-1989) = 0;
                end
                productionNuclear(l-1989) = Electricity_Data.Nuclear_Production(find(Electricity_Data.Year == l & strcmp(Electricity_Data.Country, countryChoice) == 1));
                if productionNuclear(l-1989) == -9999
                    productionNuclear(l-1989) = 0;
                end
            end

            subplot(2,2,2);
            plot(year,productionHydro,'-b+', year,productionSolar,'-ro', year,productionWind,'-g.', year, productionNuclear,'-m^');
            title('Energy Production Per Year by Type');
            xlabel('Year');ylabel('Energy (Million kWh)');
            legend('Hydro','Solar','Wind','Nuclear','Location','northwest');
            %end Line graph of production types per year
            
            %Pie chart of production types
            avgHydro = mean(productionHydro);
            avgSolar = mean(productionSolar);
            avgWind = mean(productionWind);
            avgNuclear = mean(productionNuclear);

            subplot(2,2,3)
            avgProduction = [avgHydro avgSolar avgWind avgNuclear];
            pie(avgProduction);
            title('Average Energy Production Distribution');
            legend('Hydro','Solar','Wind','Nuclear','Location','westoutside');
            %end Pie chart of production types
            
            %Energy surplus and deficit
            for p = 1:22
                surplus(p) = production(p) - demand(p);
            end

            subplot(2,2,4);
            bar(year, surplus);
            title('Energy Surplus Per Year');
            xlabel('Year');ylabel('Energy (Million kWh)');
            %end Energy surplus and deficit

            fprintf('|------------------------------------|\n|     If charts are difficult        |\n|      to read, increase size,       |\n|       but do not cover this        | \n|               box.                 |\n| _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _|\n');
            
            nextChoice = menu('Now what would you like to do?','Analyze a year','Analyze another country','Analyze a production type');
            
            if nextChoice == 1
                val = 10;
            elseif nextChoice == 2
                val = 20;
            elseif nextChoice == 3
                val = 30;
            end
            
            clc;
            
            closeChoice = menu('Do you want to keep any charts open?','Keep all charts','Keep only the most recent chart','Close only the most recent chart','Close all charts');
            
            if closeChoice == 2  %Keep only recent figure || close all then replot recent
                close all;
                                                %Total energy production / demand
                                                figure;
                                                subplot(2,2,1);
                                                plot(year, production, '-b*', year, demand, '-ro');
                                                title('Total Energy Production and Demand by Year');
                                                xlabel('Year');ylabel('Energy (Million kWh)');
                                                legend('Energy Production', 'Energy Demand','Location','northwest','Location','southoutside');
                                                %end Total energy production / demand

                                                %Line graph of production types per year
                                                subplot(2,2,2);
                                                plot(year,productionHydro,'-b+', year,productionSolar,'-ro', year,productionWind,'-g.', year, productionNuclear,'-m^');
                                                title('Energy Production Per Year by Type');
                                                xlabel('Year');ylabel('Energy (Million kWh)');
                                                legend('Hydro','Solar','Wind','Nuclear','Location','northwest');
                                                %end Line graph of production types per year

                                                %Pie chart of production types
                                                subplot(2,2,3)
                                                avgProduction = [avgHydro avgSolar avgWind avgNuclear];
                                                pie(avgProduction);
                                                title('Average Energy Production Distribution');
                                                legend('Hydro','Solar','Wind','Nuclear','Location','westoutside');
                                                %end Pie chart of production types

                                                %Energy surplus and deficit
                                                subplot(2,2,4);
                                                bar(year, surplus);
                                                title('Energy Surplus Per Year');
                                                xlabel('Year');ylabel('Energy (Million kWh)');
                                                %end Energy surplus and deficit
            elseif closeChoice == 3  % close only most recent
                close
            elseif closeChoice == 4  % close EVERYTHING
                close all;
            end  % end close menu
        end %end line 124 if structure
    end
    %End Country Selection
    
    
    %Production TypeSelection
    while val == 30
        productionChoice = menu('Please select a production type:', 'Hydro','Solar','Wind','Nuclear','Total Production','Back');
        
        if productionChoice == 6
            val = 1;
        end
    end

end
warning('on','all'); %Reenables warnings just in case.
