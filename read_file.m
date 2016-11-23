function Data=read_file(name)
Data=[];
f_ts = fopen(name, 'r');
while ~feof(f_ts)
    ts = fgetl(f_ts);
    ts=str2num(ts);
    Data=[Data;ts];
end