LargeSize = 10000;  %��������֮������ƴ�С
SmallSize = 4;
minp=[];maxp=[];  %�����洢���յ�λ�õľ���
folder = 'Images';
filename = 'divise';
all_size = [];

im = imread([folder '/' filename '.tif']);  %��ȡԭͼ
bw = im2bw( im );   % ת��ֵͼ����Ҫע���Ƿ���Ҫת��ֵ��7 8�ж�ѡһ��
%bw = im;

contour = bwperim(bw);  %������ȡ     
image_size = size(contour);
[tourx,toury] =  find(contour==1);  %ȥ���߿������
edge = [tourx toury]; %tour = tour'; %��ñ�Ե��Ķ�ά����

%���������㷨����������ͼ��contour����Ե��edge��������minp��maxp
%�ӱ�Ե��Ķ�ά����edge��ѡȡһ���㣬�������������õ�n�����������nС��ĳ��ֵ������ĳ��ֵ���ж�Ϊ��Ҫ������
%���۷�������������������������edge��ɾȥ��Ȼ������ȡedge�ĵ�һ������м��㡣
while ~isempty(edge)
    temp = edge(1,:);  %��ȡtour�ĵ�һ����
    index = 1;
    while 1
        %�Ӱ˸������ж��Ƿ��Ǳ�Ե
        eight1 = [-1 -1 -1 0 0 1 1 1];
        eight2 = [-1 0 1 -1 1 -1 0 1];
        for i = 1:8
            a = temp(index,1)+eight1(i); b = temp(index,2)+eight2(i); %�����Χ������
            if a>0 && a<=image_size(1) && b>0 && b<=image_size(2)
                if contour(a, b)==1
                    if ~ismember([a b], temp, 'rows')
                        temp = [temp;[a b]];
                    end
                end
            end
        end
        index = index + 1;
        % ��������Ѽ��������˳�
        size_temp = size(temp);
        if index == size_temp(1) + 1
            break;
        end
    end
    
    %��������
    size_temp = size(temp);
    % �������̫��������ͼ��Ե�����߼���̫С��ֻ��һ�������������أ�
    if size_temp(1) > LargeSize || size_temp(1) <= SmallSize
        edge = setdiff(edge, temp, 'rows'); 
    else
        all_size = [all_size size_temp(1)];
        edge = setdiff(edge, temp, 'rows'); 
        minp = [minp; min(temp,[],1)];
        maxp = [maxp; max(temp,[],1)];
    end
end

% ������򣬲��Խ��������ȷ����minp��maxp��ԭͼ������ʾ
figure;
imshow(bw);
hold on;
size_p = size(minp);
for i = 1:size_p(1)
    rectangle('Position',[minp(i,2) minp(i,1) maxp(i,2)-minp(i,2) maxp(i,1)-minp(i,1)],'LineWidth',3,'EdgeColor','b');
    % ����������������������������ɾ��
    txt = num2str(i);
    text(minp(i,2),minp(i,1),txt,'Color','blue','FontSize',10);
end
hold off;

%����xml������minp��maxp����xml
%xml(folder,filename,image_size,minp,maxp);