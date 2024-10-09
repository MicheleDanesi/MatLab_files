
% This program works for cycling stress tests. It works fine if the data
% collection is done in a specific way: 
% 1) the names of the data files must be saved indicating one of the
% conditions explicited in (*). As an example of a name: 
% 20230714_153748_Five%__30cycles_0.4mm-s_PI_res_Y
% The program understands that the max elongation for that data file is
% Five%, the number of cycles are 30 (stored in the data.cycles5 variable)
% and saves the time versus resistance values in data.FivePercent

path = 'C:\Users\Minchiele\Desktop\Università\Progetti\Sviluppo_di_sensori_elettro-meccanici_nanocompositi_polimero-metallo\Prog_Stress-tests\Esil_25\';
userpath(path);
dd = dir(path);

data = struct; data.FivePercent = {}; data.TenPercent = {}; data.FifteenPercent = {}; data.TwentyPercent = {}; data.ThirtyPercent = {}; data.ThirtyFivePercent = {}; data.FortyPercent = {}; data.FiftyPercent = {}; data.StepFourPercent = {}; data.StepFivePercent = {}; 
data.cycles5 = {}; data.cycles10 = {}; data.cycles15 = {}; data.cycles20 = {}; data.cycles30 = {}; data.cycles35 = {}; data.cycles40 = {}; data.cycles50 = {};
R0 = struct; R0.FivePercent = {}; R0.TenPercent = {}; R0.FifteenPercent = {}; R0.TwentyPercent = {}; R0.ThirtyPercent = {};  R0.ThirtyfivePercent = {}; R0.FortyPercent = {};  R0.FiftyPercent = {};
aa = 1; bb = 1; cc = 1; ee = 1; ff = 1; gg = 1; hh = 1; ll = 1; mm = 1; nn = 1; oo = 1; 
for ii = 1:numel(dd)
    if ~dd(ii).isdir
        % *
        if contains(dd(ii).name,'Five%_'); data.cycles5{aa} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.FivePercent{aa,1}=(mat(:,1)-mat(1,1))*1; data.FivePercent{aa,2}=mat(:,2); R0.FivePercent{aa} = mean(mat(1:40,2)); aa=aa+1; end 
        if contains(dd(ii).name,'Ten%_'); data.cycles10{bb} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.TenPercent{bb,1}=(mat(:,1)-mat(1,1))*1; data.TenPercent{bb,2}=mat(:,2); R0.TenPercent{bb} = mean(mat(1:40,2)); bb=bb+1; end 
        if contains(dd(ii).name,'Fifteen%_'); data.cycles15{cc} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.FifteenPercent{cc,1}=(mat(:,1)-mat(1,1))*1; data.FifteenPercent{cc,2}=mat(:,2); R0.FifteenPercent{cc} = mean(mat(1:40,2)); cc=cc+1; end
        if contains(dd(ii).name,'Twenty%_'); data.cycles20{ee} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.TwentyPercent{ee,1}=(mat(:,1)-mat(1,1))*1; data.TwentyPercent{ee,2}=mat(:,2); R0.TwentyPercent{ee} = mean(mat(1:40,2)); ee=ee+1; end
        if contains(dd(ii).name,'Thirty%_'); data.cycles30{ff} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.ThirtyPercent{ff,1}=(mat(:,1)-mat(1,1))*1; data.ThirtyPercent{ff,2}=mat(:,2); R0.ThirtyPercent{ff} = mean(mat(1:40,2)); ff=ff+1; end 
        if contains(dd(ii).name,'Thirtyfive%_'); data.cycles35{mm} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.ThirtyFivePercent{mm,1}=(mat(:,1)-mat(1,1))*1; data.ThirtyFivePercent{mm,2}=mat(:,2); R0.ThirtyfivePercent{mm} = mean(mat(1:40,2)); mm=mm+1; end 
        if contains(dd(ii).name,'Forty%_'); data.cycles40{nn} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.FortyPercent{nn,1}=(mat(:,1)-mat(1,1))*1; data.FortyPercent{nn,2}=mat(:,2); R0.FortyPercent{nn} = mean(mat(1:40,2)); nn=nn+1; end 
        if contains(dd(ii).name,'Fifty%_'); data.cycles50{oo} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.FiftyPercent{oo,1}=(mat(:,1)-mat(1,1))*1; data.FiftyPercent{oo,2}=mat(:,2); R0.FiftyPercent{oo} = mean(mat(1:40,2)); oo=oo+1; end 
        if contains(dd(ii).name,'Step4%'); mat=readmatrix(dd(ii).name); data.StepFourPercent{gg,1}=(mat(:,1)-mat(1,1)); data.StepFourPercent{gg,2}=mat(:,2); gg=gg+1; end
        if contains(dd(ii).name,'Step5%'); mat=readmatrix(dd(ii).name); data.StepFivePercent{hh,1}=(mat(:,1)-mat(1,1)); data.StepFivePercent{hh,2}=mat(:,2); hh=hh+1; end
    end
end

clear aa bb cc ee ff gg hh ll mm nn oo ii mat 

userpath('C:\Users\Minchiele\Desktop\Università\Progetti\Sviluppo_di_sensori_elettro-meccanici_nanocompositi_polimero-metallo\Prog_Stress-tests\');
existingFiles = string(); pFiles = [];
%Esil_25
numFile = [2 3 4 4 3 2]; % defines which of the data series to plot - NB: the number of file must be chosen according to the number of data series taken. It is not univoke to all

figure(101)
hold on
% Five
if ~isempty(data.FivePercent) 
    if ~isnan(data.FivePercent{numFile(1),2}(1))
        dt = data.FivePercent; nameX = dt{numFile(1),1}; nameY = dt{numFile(1),2}; R0_0 = R0.FivePercent{1,numFile(1)};
        [p5, ps5x, ps5y, tx5x, tx5y, txt5] = PlotCicliCampane(nameX, nameY, R0_0, 1.25); existingFiles(end+1)='5%'; pFiles(end+1)=p5;
    end
end
 
% Ten
if ~isempty(data.TenPercent) 
    if ~isnan(data.TenPercent{numFile(2),2}(1))
        existingFiles(end+1)='10%'; dt = data.TenPercent; nameX = dt{numFile(2),1}; nameY = dt{numFile(2),2}; R0_0 = R0.TenPercent{1,numFile(2)};
        [p10, ps10x, ps10y, tx10x, tx10y, txt10] = PlotCicliCampane(nameX, nameY, R0_0, 2.5); pFiles(end+1)=p10;
    end
end

% Twenty
if ~isempty(data.TwentyPercent)
    if ~isnan(data.TwentyPercent{numFile(3),2}(1))
        existingFiles(end+1)='20%'; dt = data.TwentyPercent; nameX = dt{numFile(3),1}; nameY = dt{numFile(3),2}; R0_0 = R0.TwentyPercent{1,numFile(3)}; 
        [p20, ps20x, ps20y, tx20x, tx20y, txt20] = PlotCicliCampane(nameX, nameY, R0_0, 5); pFiles(end+1)=p20;
    end
end

% Thirty
if ~isempty(data.ThirtyPercent) 
    if ~isnan(data.ThirtyPercent{numFile(4),2}(1))
        existingFiles(end+1)='30%'; dt = data.ThirtyPercent; nameX = dt{numFile(4),1}; nameY = dt{numFile(4),2}; R0_0 = R0.ThirtyPercent{1,numFile(4)};
        [p30, ps30x, ps30y, tx30x, tx30y, txt30] = PlotCicliCampane(nameX, nameY, R0_0, 7.5); pFiles(end+1)=p30;
    end
end

% Forty
if ~isempty(data.FortyPercent)
    if ~isnan(data.FortyPercent{numFile(5),2}(1))
        existingFiles(end+1)='40%'; dt = data.FortyPercent; nameX = dt{numFile(5),1}; nameY = dt{numFile(5),2}; R0_0 = R0.FortyPercent{1,numFile(5)};
        [p40, ps40x, ps40y, tx40x, tx40y, txt40] = PlotCicliCampane(nameX, nameY, R0_0, 10); pFiles(end+1)=p40;
    end
end

% Fifty
if ~isempty(data.FiftyPercent)
    if ~isnan(data.FiftyPercent{numFile(6),2}(1))
        existingFiles(end+1)='50%'; dt = data.FiftyPercent; nameX = dt{numFile(6),1}; nameY = dt{numFile(6),2}; R0_0 = R0.FiftyPercent{1,numFile(6)};
        [p50, ps50x, ps50y, tx50x, tx50y, txt50] = PlotCicliCampane(nameX, nameY, R0_0, 12.5); pFiles(end+1)=p50;
    end
end


% Plot properties
Ang = char(197);
legend(pFiles, split(existingFiles(2:end)),'Location','southeast', 'FontName', 'Calibri Light','FontSize', 16)
title(strcat('***', Ang, '/s rate - Esil *** - Stress test'), 'FontName', 'Calibri Light', 'FontSize', 16)
xlabel('time [units 0.2s]', 'FontName', 'Calibri Light', 'FontSize', 16)
ylabel('R measured [Ω]', 'FontName', 'Calibri Light', 'FontSize', 16)
set(gca,'FontSize',16, 'FontName', 'Calibri Light')
hold off

figure(102)
hold on
if ~isempty(data.FivePercent)
    if ~isnan(data.FivePercent{numFile(1),2}(1)); plot(ps5x,ps5y,'LineWidth', 3); text(tx5x, tx5y, strcat('5% - ',txt5), 'FontName', 'Calibri Light', 'FontSize', 16); end
end
if ~isempty(data.TenPercent)
    if ~isnan(data.TenPercent{numFile(2),2}(1)); plot(ps10x,ps10y,'LineWidth', 3); text(tx10x, tx10y, strcat('10% - ',txt10), 'FontName', 'Calibri Light', 'FontSize', 16); end
end
if ~isempty(data.TwentyPercent)
    if ~isnan(data.TwentyPercent{numFile(3),2}(1)); plot(ps20x,ps20y,'LineWidth', 3); text(tx20x, tx20y, strcat('20% - ',txt20), 'FontName', 'Calibri Light', 'FontSize', 16); end
end
if ~isempty(data.ThirtyPercent)
    if ~isnan(data.ThirtyPercent{numFile(4),2}(1)); plot(ps30x,ps30y,'LineWidth', 3); txt(tx30x, tx30y, strcat('30% - ',txt30), 'FontName', 'Calibri Light', 'FontSize', 16); end
end
if ~isempty(data.FortyPercent)
    if ~isnan(data.FortyPercent{numFile(5),2}(1)); plot(ps40x,ps40y,'LineWidth', 3); text(tx40x, tx40y, strcat('40% - ',txt40), 'FontName', 'Calibri Light', 'FontSize', 16); end
end
if ~isempty(data.FiftyPercent)
    if ~isnan(data.FiftyPercent{numFile(6),2}(1)); plot(ps50x,ps50y,'LineWidth', 3); text(tx50x, tx50y, strcat('50% - ',txt50), 'FontName', 'Calibri Light', 'FontSize', 16); end
end
title(strcat('***', Ang, '/s rate - Esil *** - Single cycle'), 'FontName', 'Calibri Light', 'FontSize', 16)
xlabel('Elongation [mm]', 'FontName', 'Calibri Light', 'FontSize', 16); ylabel('R measured [Ω]', 'FontName', 'Calibri Light', 'FontSize', 16); set(gca,'FontSize',16, 'FontName', 'Calibri Light')

hold off
    





%% Indentation 
path = 'C:\Users\Minchiele\Desktop\Università\Progetti\Sviluppo_di_sensori_elettro-meccanici_nanocompositi_polimero-metallo\Prog_Stress-tests\Esil_27\indentation';
userpath(path);
dd = dir(path);

data = struct; data.ind = {}; data.R0 = {}; 
aa = 1; 
for ii = 1:numel(dd)
    if ~dd(ii).isdir
        if contains(dd(ii).name,'step0.1'); mat=readmatrix(dd(ii).name); data.ind{aa,1}=(mat(:,1)-mat(1,1))*1; data.ind{aa,2}=mat(:,2); data.R0{aa} = mean(mat(1:40,2)); aa=aa+1; end    
    end
end 
numb = 2;
indentation(data.ind{numb,1}, data.ind{numb,2});
%{
name = data.ind;
figure(100)
hold on
for ii=1:numel(name)/2    
    plot(name{ii,1}, name{ii,2},'LineWidth',2,'DisplayName', strcat('data', string(ii)))
end
for ii=1:int32(length(data.ind{1,1})/50)
    xline(data.ind{1,1}(ii*50));
end
hold off
%}


%% Plotting
name = data.FivePercent;
figure(100)
hold on
for ii=1:numel(name)/2    
    plot(name{ii,1}, name{ii,2},'LineWidth',2,'DisplayName', strcat('data', string(ii)))
end
legend
hold off
ylim([0 5e4]);

%% All maxima points
data19 = Reader('C:\Users\Minchiele\Desktop\Università\Progetti\Sviluppo_di_sensori_elettro-meccanici_nanocompositi_polimero-metallo\Prog_Stress-tests\Esil_19\');
data21 = Reader('C:\Users\Minchiele\Desktop\Università\Progetti\Sviluppo_di_sensori_elettro-meccanici_nanocompositi_polimero-metallo\Prog_Stress-tests\Esil_21_stress\');
data23 = Reader('C:\Users\Minchiele\Desktop\Università\Progetti\Sviluppo_di_sensori_elettro-meccanici_nanocompositi_polimero-metallo\Prog_Stress-tests\Esil_23_stress\');
data25 = Reader('C:\Users\Minchiele\Desktop\Università\Progetti\Sviluppo_di_sensori_elettro-meccanici_nanocompositi_polimero-metallo\Prog_Stress-tests\Esil_25\');
data27 = Reader('C:\Users\Minchiele\Desktop\Università\Progetti\Sviluppo_di_sensori_elettro-meccanici_nanocompositi_polimero-metallo\Prog_Stress-tests\Esil_27\');

%% Reader (function version of the first manual reader)

function [data] = Reader(path)
userpath(path);
dd = dir(path);

data = struct; data.FivePercent = {}; data.TenPercent = {}; data.FifteenPercent = {}; data.TwentyPercent = {}; data.ThirtyPercent = {}; data.ThirtyFivePercent = {}; data.FortyPercent = {}; data.FiftyPercent = {}; data.StepFourPercent = {}; data.StepFivePercent = {};
data.cycles5 = {}; data.cycles10 = {}; data.cycles15 = {}; data.cycles20 = {}; data.cycles30 = {}; data.cycles35 = {}; data.cycles40 = {}; data.cycles50 = {};
R0 = struct; R0.FivePercent = {}; R0.TenPercent = {}; R0.FifteenPercent = {}; R0.TwentyPercent = {}; R0.ThirtyPercent = {};  R0.ThirtyfivePercent = {}; R0.FortyPercent = {};  R0.FiftyPercent = {};
aa = 1; bb = 1; cc = 1; ee = 1; ff = 1; gg = 1; hh = 1; ll = 1; mm = 1; nn = 1; oo = 1;
for ii = 1:numel(dd)
    if ~dd(ii).isdir
        % *
        if contains(dd(ii).name,'Five%_'); data.cycles5{aa} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.FivePercent{aa,1}=(mat(:,1)-mat(1,1))*1; data.FivePercent{aa,2}=mat(:,2); R0.FivePercent{aa} = mean(mat(1:40,2)); aa=aa+1; end
        if contains(dd(ii).name,'Ten%_'); data.cycles10{bb} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.TenPercent{bb,1}=(mat(:,1)-mat(1,1))*1; data.TenPercent{bb,2}=mat(:,2); R0.TenPercent{bb} = mean(mat(1:40,2)); bb=bb+1; end
        if contains(dd(ii).name,'Fifteen%_'); data.cycles15{cc} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.FifteenPercent{cc,1}=(mat(:,1)-mat(1,1))*1; data.FifteenPercent{cc,2}=mat(:,2); R0.FifteenPercent{cc} = mean(mat(1:40,2)); cc=cc+1; end
        if contains(dd(ii).name,'Twenty%_'); data.cycles20{ee} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.TwentyPercent{ee,1}=(mat(:,1)-mat(1,1))*1; data.TwentyPercent{ee,2}=mat(:,2); R0.TwentyPercent{ee} = mean(mat(1:40,2)); ee=ee+1; end
        if contains(dd(ii).name,'Thirty%_'); data.cycles30{ff} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.ThirtyPercent{ff,1}=(mat(:,1)-mat(1,1))*1; data.ThirtyPercent{ff,2}=mat(:,2); R0.ThirtyPercent{ff} = mean(mat(1:40,2)); ff=ff+1; end
        if contains(dd(ii).name,'Thirtyfive%_'); data.cycles35{mm} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.ThirtyFivePercent{mm,1}=(mat(:,1)-mat(1,1))*1; data.ThirtyFivePercent{mm,2}=mat(:,2); R0.ThirtyfivePercent{mm} = mean(mat(1:40,2)); mm=mm+1; end
        if contains(dd(ii).name,'Forty%_'); data.cycles40{nn} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.FortyPercent{nn,1}=(mat(:,1)-mat(1,1))*1; data.FortyPercent{nn,2}=mat(:,2); R0.FortyPercent{nn} = mean(mat(1:40,2)); nn=nn+1; end
        if contains(dd(ii).name,'Fifty%_'); data.cycles50{oo} = str2num([dd(ii).name(strfind(dd(ii).name, 'cycle')-2:strfind(dd(ii).name, 'cycle')-1)]); mat=readmatrix(dd(ii).name); data.FiftyPercent{oo,1}=(mat(:,1)-mat(1,1))*1; data.FiftyPercent{oo,2}=mat(:,2); R0.FiftyPercent{oo} = mean(mat(1:40,2)); oo=oo+1; end
        if contains(dd(ii).name,'Step4%'); mat=readmatrix(dd(ii).name); data.StepFourPercent{gg,1}=(mat(:,1)-mat(1,1)); data.StepFourPercent{gg,2}=mat(:,2); gg=gg+1; end
        if contains(dd(ii).name,'Step5%'); mat=readmatrix(dd(ii).name); data.StepFivePercent{hh,1}=(mat(:,1)-mat(1,1)); data.StepFivePercent{hh,2}=mat(:,2); hh=hh+1; end
    end
end

clear aa bb cc ee ff gg hh ll mm nn oo ii mat
end

