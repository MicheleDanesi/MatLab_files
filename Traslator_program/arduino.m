function st = arduino(vel,N,mode,s)
%   st = stampa(vel,N,dir,s)
%   Function sends the command to Arduino.
%   vel: integer number, it defines the velocity in rpm
%   N: integer number, the number of revolutions 
%   dir: 0 for right, 1 for left
%   s: serial object opened in the main file
%
%   st: struct with the value sent by arduino; .number (integer), .data (str)
    
    stringa = [num2str(vel),',',num2str(N),',',num2str(mode)];
    %send the commadn
    fprintf(s,stringa);
    %read the response
    data = fscanf(s);
    %disp(data);
    st.data = data;
    st.numero = str2double(data);
end
