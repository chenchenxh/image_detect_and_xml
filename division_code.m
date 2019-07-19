src_path='Images/黑白.tif';
dst_path='out/';
%mkdir(dst_path);%路径不存在则生成

A=imread(src_path);
[m,n,h]=size(A);
size = 1;
for i = 1:size
for j = 1:size
m_start=1+(i-1)*fix(m/size);
m_end=i*fix(m/size);
n_start=1+(j-1)*fix(n/size);
n_end=j*fix(n/size);
aa=A(m_start:m_end,n_start:n_end,:); %将每块读入矩阵
imwrite(aa,[dst_path num2str(i) '--' num2str(j) '.tif'],'tif'); %保存每块图片
end
end 