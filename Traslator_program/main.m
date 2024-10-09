function main()
s = openInst();
ss = s.port;
s1 = ss(1); %arduino
s1.Timeout = 500;
configureTerminator(s1,'CR/LF');
writelines('0', 'new_start.txt');
writelines('0', 'positions_records.txt');
motor_steps = 1600;

global stop_bool;
stop_bool = 0;

%PARENT FIGURE
fig = uifigure('Name','Traslatore','Visible','on','Position',[800, 100, 500, 620],...
    'DeleteFcn', @(fig,event) chiusura(s,s1));

%create first panel
pnl1 = uipanel('Parent',fig,'Title','General settings','Position',[10, 540, 475, 70],...
    'FontSize',14);

setZero_tx = uilabel(pnl1,'Text','Set new 0 [mm]','Position', [10 28 100 15]);
setZero = uieditfield(pnl1,'numeric','Position',[10 9 100 18],'Value',0);

btn_Reinitialize = uibutton(pnl1,'push','Text','Reinitialize','Position',[125, 4, 100, 28],...
    'ButtonPushedFcn', @(btn,event) setNewStartPosition(s1, setZero.Value));

btn_stop = uibutton(pnl1,'push','Text','Stop','Position',[370, 4, 100, 28],...
    'ButtonPushedFcn', @(btn,event) stopbtn());

btn_Abs_zero = uibutton(pnl1,'push','Text','Absolute 0','Position',[240, 4, 100, 28],...
    'ButtonPushedFcn', @(btn,event) setStartPosition(s1));

%create second panel
pnl2 = uipanel('Parent',fig,'Title','Single motion settings','Position',[10, 420, 475, 110],...
    'FontSize',14);
mode = uidropdown(pnl2,'Position',[10 55 100 20],'Items',{'Stretching','Compression'});
mode.ItemsData = [0 1];

dd = uidropdown(pnl2,...
    'Position',[150 55 100 20],...
    'Items',{'0.05 mm','0.1 mm','0.5 mm','1 mm','1.25 mm','2.50 mm','5 mm','10 mm','15 mm','25 mm','50 mm'},...
    'Value','5 mm');
dd.ItemsData = [motor_steps/100 motor_steps/50 motor_steps/10 motor_steps/5 motor_steps/4 motor_steps/2 motor_steps motor_steps*2 motor_steps*3 motor_steps*5 motor_steps*10];

velocity_tx = uilabel(pnl2,'Text','Velocity [mm/s]','Position', [10 32 100 15]);
velocity = uieditfield(pnl2,'numeric','Position',[10 10 100 20],'Value',1);

elongation_tx = uilabel(pnl2,'Text','Elongation [mm]','Position', [150 32 100 15]);
elongation_sg = uieditfield(pnl2,'numeric','Position',[150 10 100 20],'Value',0);

btn_move = uibutton(pnl2,'push','Text','Move','Position',[390, 12, 70, 40],'ButtonPushedFcn', @(btn,event) move(velocity.Value,s1,mode.Value,dd.Value,elongation_sg.Value,motor_steps));
btn.Text = 'Move';

% create third panel
pnl3 = uipanel('Parent',fig,'Title','Training settings','Position',[10, 300, 475, 110],'FontSize',14);
cbx = uicheckbox(pnl3, 'Text','Training','Value', 0,'Position',[250 65 105 20]);

filefolder_text = uilabel(pnl3,'Text','File folder path','Position', [10 67 200 20]);
filefolder = uieditfield(pnl3,'Position',[10 45 170 20]);

filename_text = uilabel(pnl3,'Text','File name','Position', [10 27 200 20]);
filename = uieditfield(pnl3,'Position',[10 5 170 20]);

state_text_area = uitextarea(pnl3,'Position',[350 10 120 70],'Value', {'Velocity: NaN', 'Elongation: NaN', 'Tot. cycles: NaN', 'prog. cycles: NaN'});

btn_train = uibutton(pnl3,'push','Text','Training','Position',[250, 15, 70, 40],'ButtonPushedFcn', @(btn,event) training(strcat(filefolder.Value, '\', filename.Value),s1,motor_steps,state_text_area, cbx));
btn.Text = 'Training';

% create fourth panel
pnl4 = uipanel('Parent',fig,'Title','Cycles settings','Position',[10, 140, 475, 150],'FontSize',14);
cbx = uicheckbox(pnl4, 'Text','Cycles cbx','Value', 0,'Position',[250 80 105 20]);
cbx_mode = uicheckbox(pnl4, 'Text','Mode:S=0/C=1','Value', 0,'Position',[120 45 100 20]);

velocity_cy = uilabel(pnl4,'Text','Velocity [mm/s]','Position', [10 105 100 15]);
velocity_1 = uieditfield(pnl4,'numeric','Position',[10 85 100 20],'Value',1);

waiting_cy = uilabel(pnl4,'Text','Waiting time [s]','Position', [10 65 100 15]);
waiting_1 = uieditfield(pnl4,'numeric','Position',[10 45 100 20],'Value',1);

elongation_cy = uilabel(pnl4,'Text','Elongation [mm]','Position', [10 25 100 15]);
elongation_1 = uieditfield(pnl4,'numeric','Position',[10 5 100 20],'Value',1);

num_cy = uilabel(pnl4,'Text','Number of cycles','Position', [120 105 100 15]);
num_1 = uieditfield(pnl4,'numeric','Position',[120 85 100 20],'Value',1);

state_text_area_1 = uitextarea(pnl4,'Position',[350 30 120 70],'Value', {'Velocity:  NaN', 'Elongation:  NaN', 'Tot. cycles:  NaN', 'prog. cycles:  NaN'});

btn_cycles = uibutton(pnl4,'push','Text','Cycles','Position',[250, 30, 70, 40],'ButtonPushedFcn', ...
    @(btn,event) cycles(velocity_1.Value, elongation_1.Value,waiting_1.Value, ...
    num_1.Value,s1,motor_steps,state_text_area_1, cbx, cbx_mode));
btn.Text = 'cycles';

% create fifth panel
pnl5 = uipanel('Parent',fig,'Title','Step stretch settings','Position',[10, 10, 475, 120],'FontSize',14);

cbx_mode_2 = uicheckbox(pnl5, 'Text','Mode:S=0/C=1','Value', 0,'Position',[240 70 100 20]);

velocity_st = uilabel(pnl5,'Text','Velocity [mm/s]','Position', [10 80 100 15]);
velocity_2 = uieditfield(pnl5,'numeric','Position',[10 60 100 20],'Value',1);

waiting_st = uilabel(pnl5,'Text','Wait after step [s]','Position', [10 35 100 15]);
waiting_2 = uieditfield(pnl5,'numeric','Position',[10 15 100 20],'Value',1);

elongation_st = uilabel(pnl5,'Text','Step elongation [mm]','Position', [120 80 100 15]);
elongation_2 = uieditfield(pnl5,'numeric','Position',[120 60 100 20],'Value',1);

num_st = uilabel(pnl5,'Text','Number of steps','Position', [120 35 100 15]);
num_2 = uieditfield(pnl5,'numeric','Position',[120 15 100 20],'Value',1);

state_text_area_2 = uitextarea(pnl5,'Position',[350 20 120 70],'Value', {'Velocity:  NaN', 'Elongation:  NaN', 'Tot. steps:  NaN', 'Prog. steps:  NaN'});

btn_steps = uibutton(pnl5,'push','Text','Steps','Position',[250, 20, 70, 40],'ButtonPushedFcn', ...
    @(btn,event) steps(velocity_2.Value, elongation_2.Value,waiting_2.Value, ...
    num_2.Value,s1,motor_steps,state_text_area_2, cbx_mode_2));
btn.Text = 'cycles';

end

function stopbtn(stop_bool)
global stop_bool;
stop_bool = 1;
end

function refresh_position(p)
starter = readlines('positions_records.txt'); starter = str2double(starter(end-1));
writelines(num2str(p+starter), 'positions_records.txt', WriteMode='append');
end

function v = convert(vel)
v = num2str((vel*60)/5);
end

function P = StepToPosition(N,stepsPerRevolution)
P = (5*N)/stepsPerRevolution;
end

function x = motor_steps_converter(value)
x = uint32(1600*value/5);
end

function move(velocity,s,mode,N,manual_elong,m_steps)
vel = convert(velocity);
if manual_elong == 0; final_elong = N;
else final_elong = motor_steps_converter(manual_elong); end
num = arduino(vel,final_elong,mode,s);
if num.numero >= 0
    if mode == 0; p2 = StepToPosition(num.numero,m_steps); refresh_position(p2);
    elseif mode == 1; p2 = -StepToPosition(num.numero,m_steps); refresh_position(p2);
    else; disp("Wrong command! Reinitialize the system"); 
    end
end
end

function training(path,s,m_steps,state_text_area, chbox)
if chbox.Value == 0; disp('Click the chackbox!'); return; end
if path == ""; disp('Insert a correct path'); return; end
global stop_bool;
try 
    fid = fopen(path,'r');
catch 
    disp('Wrong filename. (Remember to omit last -> \ in folder path)');
end
lines = strings; ii = 1; values = [];
while ~feof(fid)
    lines(ii) = fgetl(fid); chline = convertStringsToChars(lines(ii));
    for jj=1:numel(chline); if chline(jj) == ' '; ref = jj+1; break; end; end
    values(ii) = str2num(convertCharsToStrings(chline(ref:end))); ii = ii + 1;
end
t_velocity = values(1); t_waittime = values(2); t_mode = values(3); t_length = values(4); t_elong = []; t_cycles = []; aa = 0; bb = 0;
for kk = 5:numel(values)
    if rem(kk,2) ~= 0; aa = aa +1; t_elong(aa) = values(kk)*t_length;
    else; bb = bb + 1; t_cycles(bb) = values(kk);
    end
end

if t_mode == 1; mode.a = 1; mode.b = 0; else; mode.a = 0; mode.b = 1; end
for ii = 1:numel(t_elong)
    for jj = 1:t_cycles(ii)
        state_text_area.Value = {strcat('Velocity: ',num2str(t_velocity)), strcat('Elongation:',num2str(t_elong(ii))), ...
                                strcat('Tot. cycles:', num2str(t_cycles(ii))), strcat('Prog. cycles:',num2str(jj))};
        N = motor_steps_converter(t_elong(ii));
        move(t_velocity,s,mode.a,N,0,m_steps);
        move(t_velocity,s,mode.b,N,0,m_steps);
        if stop_bool == 1; break; end
        pause('on'); pause(t_waittime);
    end
    pause('on'); pause(t_waittime*10);
    if stop_bool == 1; break; end
end
disp('End of training')
chbox.Value = 0;
state_text_area.Value = {'Velocity: NaN', 'Elongation:  NaN', 'Tot. cycles: NaN','Prog. cycles: NaN'};
stop_bool = 0;
end

function cycles(velocity,elong,waittime,n_cycles,s,m_steps,state_text_area, chbox, cbx_mode)
if chbox.Value == 0; disp('Click the chackbox!'); return; end
global stop_bool;
if cbx_mode.Value == 0; mode.a = 0; mode.b = 1; 
else; mode.a = 1; mode.b = 0; end
for jj = 1:n_cycles
        state_text_area.Value = {strcat('Velocity: ',num2str(velocity)), strcat('Elongation:',num2str(elong)), ...
                                strcat('Tot. cycles:', num2str(n_cycles)), strcat('Prog. cycles:',num2str(jj))};
        N = motor_steps_converter(elong);
        move(velocity,s,mode.a,N,0,m_steps);
        move(velocity,s,mode.b,N,0,m_steps);
        if stop_bool == 1; break; end
        pause('on'); pause(waittime);
end
disp('End of cycling')
state_text_area.Value = {'Velocity: NaN', 'Elongation:  NaN', 'Tot. cycles: NaN','Prog. cycles: NaN'};
end

function steps(velocity,elong,waittime,n_steps,s,m_steps,state_text_area, cbx_mode)
global stop_bool; 
if cbx_mode.Value == 0; mode.a = 0; mode.b = 1;
else; mode.a = 1; mode.b = 0; end

for jj = 1:n_steps
        state_text_area.Value = {strcat('Velocity: ',num2str(velocity)), strcat('Elongation:',num2str(elong*jj)), ...
                                strcat('Tot. steps:', num2str(n_steps)), strcat('Prog. steps:',num2str(jj))};
        N = motor_steps_converter(elong);
        move(velocity,s,mode.a,N,0,m_steps);
        if stop_bool == 1; break; end
        pause('on'); pause(waittime);
end
for jj = 1:n_steps
        state_text_area.Value = {strcat('Velocity: ',num2str(velocity)), strcat('Elongation:',num2str(elong*(n_steps-jj))), ...
                                strcat('Tot. steps:', num2str(n_steps)), strcat('Prog. steps:',num2str(n_steps+jj))};
        N = motor_steps_converter(elong);
        move(velocity,s,mode.b,N,0,m_steps);
        if stop_bool == 1; break; end
        pause('on'); pause(waittime);
end
disp('End of steps')
stop_bool = 0;
state_text_area.Value = {'Velocity: NaN', 'Elongation:  NaN', 'Tot. steps: NaN','Prog. steps: NaN'};
end
 
function setNewStartPosition(s1, new_p)
old_p = readlines('new_start.txt'); 
starter = readlines('positions_records.txt'); if numel(starter)>1; starter = str2double(starter(end-1)); else; starter = 0; end
if str2double(old_p) ~= new_p; writelines(num2str(new_p), 'new_start.txt'); end
if new_p ~= starter
    movement = new_p-starter; 
    if movement > 0; move(2,s1,0,motor_steps_converter(movement),0,1600); 
    else move(2,s1,1,motor_steps_converter(abs(movement)),0,1600); end
else disp('The absolute start and the set one are the same!');
end
end

function setStartPosition(s1)
starter = readlines('positions_records.txt'); if numel(starter)>1; starter = str2double(starter(end-1)); end
steps = motor_steps_converter(starter);
if starter~=0; move(2,s1,1,steps,0,1600); end
end

function chiusura(s,s1)
disp('Attendere routine di chiusura');
starter = readlines('positions_records.txt'); starter = str2double(starter(end-1));
steps = motor_steps_converter(starter);
if starter~=0; none = arduino(24,steps,1,s1); end
disp("Finito");
closeInst(s);
end
