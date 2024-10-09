function s = openInst()

s = struct;
tmp = serialport('COM5', 9600);
writeline(tmp,'*IDN?');
risp = readline(tmp);
s.port = tmp;
s.name = risp;

end

