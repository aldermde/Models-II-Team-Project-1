%Models II Team Project I
%Group:

clear all;
close all;
clc;

load Electricity_Data.mat;

%Clearing some of the bad values.
%The rest are done below and were done before this was written.
%Not moving them up here.

for r = 1:5170
    if Electricity_Data.Total_Production(r) == -9999
        Electricity_Data.Total_Production(r) = 0;
    elseif Electricity_Data.Demand(r) == -9999
        Electricity_Data.Demand(r) = 0;
    end
end

val = 0;
Super_Awesome = val;
Doctor_Bucks = val;

warning('off','all'); %Disables unneeded warning messages that may appear.

while Doctor_Bucks == Super_Awesome %Obligatory brown nosing
     
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
       chartChoice=menu('Please select how you would like to view this information.','Pie Chart of Power Used','Graphs of Contribuiters');
        switch chartChoice;
            case 1 %The user has chose to look at a pie chart of production for that year
                X=find(Electricity_Data.Hydro_Production >-9999 & Electricity_Data.Year==yearChoice);
                HydroSum=sum(Electricity_Data.Hydro_Production(X)); %Summ of all the Hydro Production for that year
                
                Y=find(Electricity_Data.Nuclear_Production >-9999 & Electricity_Data.Year==yearChoice);
                NuclearSum=sum(Electricity_Data.Nuclear_Production(Y)); % Sum of all of the Nuclear Production for that year
                
                Z=find(Electricity_Data.Solar_Production >-9999 & Electricity_Data.Year==yearChoice);
                SolarSum=sum(Electricity_Data.Solar_Production(Z)); %Sum of all the Solar Production for that year
                
                W=find(Electricity_Data.Wind_Production >-9999 & Electricity_Data.Year==yearChoice);
                WindSum=sum(Electricity_Data.Wind_Production(W)); % Sum of all the Wind Production for that year
                
                PieInfo= [HydroSum NuclearSum SolarSum WindSum];
                
                Names= {'Hydro','Nuclear','Solar','Wind'}; %Placing those sums into a pie chart with labels
                
                
                
                PieChart= pie3(PieInfo);
                legend(Names,'Location','SouthEast');
                str=sprintf('Pie Chart Of How Power Was Used In %d',yearChoice);
                title(str,'FontSize',15);
                
                
            case 2 % The user has chosen to look at the top and bottom contributors for that year
                contributerChoice=menu('Would you like to see the top contibuters or the bottom contributers?','Top Ten Contributers','Bottom Ten Contributers');
                % Hydro Min & Max
                X=find(Electricity_Data.Hydro_Production> -9999 & Electricity_Data.Year==yearChoice);
                Hydro1=sort(Electricity_Data.Hydro_Production(X));
                Hydro2=sort(Electricity_Data.Hydro_Production(X),'descend');
                HydroMin=Hydro1(1:10);
                HydroMax=Hydro2(1:10);
                
                %Nuclear Min & Max
                X1=find(Electricity_Data.Nuclear_Production> -9999 & Electricity_Data.Year==yearChoice);
                Nuclear1=sort(Electricity_Data.Nuclear_Production(X1));
                Nuclear2=sort(Electricity_Data.Nuclear_Production(X1),'descend');
                NuclearMin=Nuclear1(1:10);
                NuclearMax=Nuclear2(1:10);
                
                %Solar Min & Max
                X2=find(Electricity_Data.Solar_Production> -9999 & Electricity_Data.Year==yearChoice);
                Solar1=sort(Electricity_Data.Solar_Production(X2));
                Solar2=sort(Electricity_Data.Solar_Production(X2),'descend');
                SolarMin=Solar1(1:10);
                SolarMax=Solar2(1:10);
                
                %Wind Min & Max
                X3=find(Electricity_Data.Wind_Production> -9999 & Electricity_Data.Year==yearChoice);
                Wind1=sort(Electricity_Data.Wind_Production(X3));
                Wind2=sort(Electricity_Data.Wind_Production(X3),'descend');
                WindMin=Wind1(1:10);
                WindMax=Wind2(1:10);
                
                %Total Min & Max
                X4=find(Electricity_Data.Total_Production> -9999 & Electricity_Data.Year==yearChoice & Electricity_Data.Demand > -9999);
                Total1=sort(Electricity_Data.Total_Production(X4));
                Total2=sort(Electricity_Data.Total_Production(X4),'descend');
                TotalMin=Total1(1:10);
                TotalMax=Total2(1:10);
                 
                %Country Location Max
                for k=1:10;
                    HydroMaxCountries{k}=Electricity_Data.Country{find(Electricity_Data.Hydro_Production==HydroMax(k))};
                    NuclearMaxCountries{k}=Electricity_Data.Country{find(Electricity_Data.Nuclear_Production==NuclearMax(k))};
                    SolarMaxCountries{k}=Electricity_Data.Country{find(Electricity_Data.Solar_Production==SolarMax(k))};
                    WindMaxCountries{k}=Electricity_Data.Country{find(Electricity_Data.Wind_Production==WindMax(k))};
                    TotalMaxCountries{k}=Electricity_Data.Country{find(Electricity_Data.Total_Production==TotalMax(k))};
                end
                
                %Country Location Min
                for k=1:10;
                    HydroMinCountries{k}=Electricity_Data.Country{find(Electricity_Data.Hydro_Production==HydroMin(k))};
                    NuclearMinCountries{k}=Electricity_Data.Country{find(Electricity_Data.Nuclear_Production==NuclearMin(k))};
                    SolarMinCountries{k}=Electricity_Data.Country{find(Electricity_Data.Solar_Production==SolarMin(k))};
                    WindMinCountries{k}=Electricity_Data.Country{find(Electricity_Data.Wind_Production==WindMin(k))};
                    TotalMinCountries{k}=Electricity_Data.Country{find(Electricity_Data.Total_Production==TotalMin(k))};
                end
                
                
                switch contributerChoice
                    case 1
                        %Hydro Max Contributers
                        figure(1);
                        bar(HydroMax,'b');
                        title('Top ten Hydro Contributers');
                        set(gca,'XTick',1:length(HydroMaxCountries'));
                        set(gca,'XTickLabel',HydroMaxCountries');
                        ylabel('Power (kWh,millions)');
                        
                        %Nuclear Max Contributers
                        figure(2);
                        bar(NuclearMax,'g');
                        title('Top Ten Nuclear Contributers');
                        set(gca,'XTick',1:length(NuclearMaxCountries'));
                        set(gca,'XTickLabel',NuclearMaxCountries');
                        ylabel('Power (kWh,millions)');
                        
                        %Solar Max Contributers
                        figure(3);
                        bar(SolarMax,'y');
                        title('Top Ten Solar Contributers');
                        set(gca,'XTick',1:length(SolarMaxCountries'));
                        set(gca,'XTickLabel',SolarMaxCountries');
                        ylabel('Power (kWh,millions)');
                        
                        %Wind Max Contributers
                        figure(4);
                        bar(WindMax,'m');
                        title('Top Ten Wind Contributers');
                        set(gca,'XTick',1:length(WindMaxCountries'));
                        set(gca,'XTickLabel',WindMaxCountries');
                        ylabel('Power (kWh,millions)');
                        
                        %Total Max Contributers
                        figure(5);
                        bar(TotalMax,'r');
                        title('Top Ten Total Contributers');
                        set(gca,'XTick',1:length(TotalMaxCountries'));
                        set(gca,'XTickLabel',TotalMaxCountries');
                        ylabel('Power (kWh,millions)');
                        
                        
                    case 2
                        %Hydro Min Contributers
                        figure(1);
                        bar(HydroMin,'b');
                        title('Bottom Ten Hydro Contributers');
                        set(gca,'XTick',1:length(HydroMinCountries'));
                        set(gca,'XTickLabel',HydroMinCountries');
                        ylabel('Power (kWh,millions)');
                        
                        %Nuclear Min Contributers
                        figure(2);
                        bar(NuclearMin,'g');
                        title('Bottom Ten Nuclear Contributers');
                        set(gca,'XTick',1:length(NuclearMinCountries'));
                        set(gca,'XTickLabel',NuclearMinCountries');
                        ylabel('Power (kWh,millions)');
                        
                        %Solar Min Contributers
                        figure(3);
                        bar(SolarMin,'y');
                        title('Bottom Ten Solar Contributers');
                        set(gca,'XTick',1:length(SolarMinCountries'));
                        set(gca,'XTickLabel',SolarMinCountries');
                        ylabel('Power (kWh,millions)');
                        
                        %Wind Min Contributers
                        figure(4);
                        bar(WindMin,'m');
                        title('Bottom Ten Wind Contributers');
                        set(gca,'XTick',1:length(WindMinCountries'));
                        set(gca,'XTickLabel',WindMinCountries');
                        ylabel('Power (kWh,millions)');
                        
                        %Total Min Contributers
                        figure(5);
                        bar(TotalMin,'r');
                        title('Bottom Ten Total Contributers');
                        set(gca,'XTick',1:length(TotalMinCountries'));
                        set(gca,'XTickLabel',TotalMinCountries');
                        ylabel('Power (kWh,millions)');
                end
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
                        %Begin catch for Russia, 'cause it had to be special
                        if strcmp(countryChoice,'Russia')
                            countryChoice = 'Russian Federation';
                        else   
                            fprintf('Warning: Entries are case sensitive.\n\n');
                            fprintf('Entry of "%s" is not a valid country.\n\nPlease input a valid country:', countryChoice);
                            countryChoice = input(' ', 's');
                        end
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
            
            %Master Title
            set(gcf,'NextPlot','add');
            axes;
            h = title(countryChoice);
            set(gca,'Visible','off');
            set(h,'Visible','on');
            %Master Title
            
            %This shows the user the space in the command window that
            %shouldn't be covered.
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
                                                
                                                %Master title
                                                set(gcf,'NextPlot','add');
                                                axes;
                                                h = title(countryChoice);
                                                set(gca,'Visible','off');
                                                set(h,'Visible','on');
                                                %Master title
                                                
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

warning('on','all'); %Reenables warnings just in case.

