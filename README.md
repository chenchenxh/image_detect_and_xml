
# 卫星地图黑白图像的区域检测和xml生成

[TOC]

## 使用

包含三个文件，devision.m是分割图像。area.m是检测区域的，顺带调用xml.m

- 每个文件的前部分都是参数，直接修改成需要处理的文件夹名和文件名即可
- area的 .tif 要改成实际情况需要的文件后缀名
- 需要提前在同路径下创建xml空文件夹用来存储xml文件

## 原理

### 分割文件

分割文件比较简单，但是matlab会对文件进行压缩，不知道会不会对结果产生影响。

### 检测区域

步骤：

1. 将图片转换为二值图

2. 对二值图提取轮廓（主要是减少下面的计算量）

3. 取二值图的任一个点，进行区域生长算法（以该点3*3区域搜索），然后不断扩大到该区域完整。取得一块区域

4. 然后将上述区域从二值图中删去，然后重复3，4步骤

5. 由此取得所有区域的边缘点，判断各个区域是否符合要求（限定最大值和最小值，将只有一两个像素的区域和整个地图的区域去掉）

6. 输出原来图片跟每个区域检测框的数字，判断是否正确

   

### 生成xml文件

没有对文件的utf-8的标注删去，应该不影响。

直接按照matlab的xml生成，对检测区域的输出进行处理。



## reference

1. [使用Matlab对二值图像进行轮廓提取](https://unordered.org/timelines/59d5af2422c01000)
2. [区域生长算法原理](https://blog.csdn.net/shenziheng1/article/details/50878911)
3. [在图像中画矩形框（matlab）](https://blog.csdn.net/renyuanxingxing/article/details/78835275)
4. [向数据点添加文本说明](https://ww2.mathworks.cn/help/matlab/ref/text.html)
5. [PASCAL VOC 数据集格式](https://arleyzhang.github.io/articles/1dc20586/)
6. [matlab生成xml示例](https://blog.csdn.net/Allyli0022/article/details/52035435)