clear;clc;
fid=fopen('test.stl', 'r');%创建一个STL文件，文件名test.stl
V=0;    vnum=0;    report_num=0;    STLxyz=0;
%读取数据
while feof(fid) == 0    %文件指针到达文件末尾时返回真值            
      tline = fgetl(fid);   % tline获得读取到的文件内容的一行字符串
      fword = sscanf(tline, '%s');  %从获得的一行字符串中提取字符型数
if strncmpi(fword, 'vertex',6) == 1;   %读取坐标,如果指针所指地址内容为vertex，逻辑为1
      STLxyz= sscanf(tline, '%*s %lf %lf %lf');%读取浮点数数据储存到STLxyz,按照列存储
      vnum = vnum + 1; 
end
    if  vnum~=report_num
         report_num=vnum;
         v(:,vnum)=STLxyz;     
    end
end
vout = v';  
%计算体积
for i=1:3:vnum-2
    xi1=vout(i,1);     yi1=vout(i,2);     zi1=vout(i,3);
    xi2=vout(i+1,1);   yi2=vout(i+1,2);   zi2=vout(i+1,3);
    xi3=vout(i+2,1);   yi3=vout(i+2,2);   zi3=vout(i+2,3);
    vi=(-xi3*yi2*zi1+xi2*yi3*zi1+xi3*yi1*zi2-xi1*yi3*zi2-xi2*yi1*zi3+xi1*yi2*zi3)/6;
    V=V+vi;
end
fprintf('The volumn of the model is: %f mm3.\n',V);
%计算面f的个数：
face=vnum/3;
fprintf('The number of the face is: %d.\n',face);
%计算不重合顶点的个数vertex：
DV=unique(vout,'rows');
[vertex,columns]=size(DV);
fprintf('The number of the vertex is: %d.\n',vertex);
%计算不重合边的个数edge：
edge=vnum/2;
fprintf('The number of the edge is: %d.\n',edge);
%计算孔的个数：
genus=(2-vertex+edge-face)/2;
fprintf('The number of the genus is: %d.\n',genus);
