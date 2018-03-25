fid=fopen('yuanzhu2.stl', 'r');%创建一个STL文件，放在与此脚本同目录的文件夹下，文件名yuanzhu2.stl改为新的文件名
V=0;    vnum=0;    report_num=0;    STLxyz=0;
while feof(fid) == 0    %文件指针到达文件末尾时返回真值            
      tline = fgetl(fid);   % tline获得读取到的文件内容的一行字符串
      fword = sscanf(tline, '%s');  %从获得的一行字符串中提取字符型数据存储在fword指针上
if strncmpi(fword, 'vertex',6) == 1;   %读取三角形点的坐标,如果指针所指地址内容为vertex，逻辑为1
      STLxyz= sscanf(tline, '%*s %lf %lf %lf');%读取浮点数数据储存到STLxyz,按照列存储
      vnum = vnum + 1; 
end
    if  vnum~=report_num
         report_num=vnum;
         v(:,vnum)=STLxyz;     
    end
end
fprintf('The number of the trangle is: %d.\n',vnum/3);
vout = v';  
for i=1:3:vnum-2
    xi1=vout(i,1);     yi1=vout(i,2);     zi1=vout(i,3);
    xi2=vout(i+1,1);   yi2=vout(i+1,2);   zi2=vout(i+1,3);
    xi3=vout(i+2,1);   yi3=vout(i+2,2);   zi3=vout(i+2,3);
    vi=(-xi3*yi2*zi1+xi2*yi3*zi1+xi3*yi1*zi2-xi1*yi3*zi2-xi2*yi1*zi3+xi1*yi2*zi3)/6;
    V=V+vi;
end
fprintf('The volumn of the model is: %f mm3.\n',V);
%总结：读取STL文件到数组中，对数组中的坐标数据处理；
%三维软件导出时，将STL文件的偏差控制设置的小一些，则分割的三角形数量较多，计算的结果也较为精确；
%本例：The volumn of the model is: 73630.476146 mm3；
%实际的外径50mm，内径25mm,高为50mm的空心圆柱的体积为73631.07782 mm3，误差已经较小。