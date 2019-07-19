LargeSize = 10000;  %检测出区域之后的限制大小
SmallSize = 4;
minp=[];maxp=[];  %用来存储最终的位置的矩阵
folder = 'Images';
filename = 'divise';
all_size = [];

im = imread([folder '/' filename '.tif']);  %读取原图
bw = im2bw( im );   % 转二值图像，需要注意是否需要转二值，7 8行二选一。
%bw = im;

contour = bwperim(bw);  %轮廓提取     
image_size = size(contour);
[tourx,toury] =  find(contour==1);  %去除边框的轮廓
edge = [tourx toury]; %tour = tour'; %获得边缘点的二维矩阵

%区域生长算法：输入整个图像contour，边缘点edge，输出结果minp和maxp
%从边缘点的二维矩阵edge中选取一个点，进行区域生长得到n个点的区域。若n小于某阈值并大于某阈值则判定为需要的区域。
%无论符不符合条件，都将这个区域从edge中删去，然后重新取edge的第一个点进行计算。
while ~isempty(edge)
    temp = edge(1,:);  %获取tour的第一个点
    index = 1;
    while 1
        %从八个方向判断是否是边缘
        eight1 = [-1 -1 -1 0 0 1 1 1];
        eight2 = [-1 0 1 -1 1 -1 0 1];
        for i = 1:8
            a = temp(index,1)+eight1(i); b = temp(index,2)+eight2(i); %获得周围的坐标
            if a>0 && a<=image_size(1) && b>0 && b<=image_size(2)
                if contour(a, b)==1
                    if ~ismember([a b], temp, 'rows')
                        temp = [temp;[a b]];
                    end
                end
            end
        end
        index = index + 1;
        % 如果区域已检测结束则退出
        size_temp = size(temp);
        if index == size_temp(1) + 1
            break;
        end
    end
    
    %处理区域
    size_temp = size(temp);
    % 如果检测框太大（整个地图边缘）或者检测框太小（只是一个或者两个像素）
    if size_temp(1) > LargeSize || size_temp(1) <= SmallSize
        edge = setdiff(edge, temp, 'rows'); 
    else
        all_size = [all_size size_temp(1)];
        edge = setdiff(edge, temp, 'rows'); 
        minp = [minp; min(temp,[],1)];
        maxp = [maxp; max(temp,[],1)];
    end
end

% 输出检测框，测试结果正不正确：将minp和maxp在原图像上显示
figure;
imshow(bw);
hold on;
size_p = size(minp);
for i = 1:size_p(1)
    rectangle('Position',[minp(i,2) minp(i,1) maxp(i,2)-minp(i,2) maxp(i,1)-minp(i,1)],'LineWidth',3,'EdgeColor','b');
    % 下面两行是输出检测框的数量，可以删除
    txt = num2str(i);
    text(minp(i,2),minp(i,1),txt,'Color','blue','FontSize',10);
end
hold off;

%生成xml：根据minp和maxp生成xml
%xml(folder,filename,image_size,minp,maxp);