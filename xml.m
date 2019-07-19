function xml(folder,filename, image_size, minp, maxp)

path = 'xml/'
xmlFileName = [filename '.xml'];    
folder = folder;
filename = filename;
segmented = '0';

width = num2str(image_size(2));
height = num2str(image_size(1));
depth = 'depth';

name = 'pigfarm';
pose = 'unspecified';
truncated = '0';
difficult = '1';

docNode = com.mathworks.xml.XMLUtils.createDocument('annotation')  ;
docRootNode = docNode.getDocumentElement;  
%docRootNode.setAttribute('attr_name','attr_value');  
  
    Node1 = docNode.createElement('folder');   
    Node1.appendChild(docNode.createTextNode(sprintf(folder)));  
    docRootNode.appendChild(Node1);  
      
    Node2 = docNode.createElement('filename');   
    Node2.appendChild(docNode.createTextNode(sprintf(filename)));  
    docRootNode.appendChild(Node2);  
  
  
    thisElement = docNode.createElement('size');   
    docRootNode.appendChild(thisElement);  
      
        dataNode = docNode.createElement('width');  
        dataNode.appendChild(docNode.createTextNode(sprintf(width)));  
        thisElement.appendChild(dataNode);  
          
        dataNode = docNode.createElement('height');  
        dataNode.appendChild(docNode.createTextNode(sprintf(height)));  
        thisElement.appendChild(dataNode);  
          
        dataNode = docNode.createElement('depth');  
        dataNode.appendChild(docNode.createTextNode(sprintf(depth)));  
        thisElement.appendChild(dataNode);  
          
    Node2 = docNode.createElement('segmented');   
    Node2.appendChild(docNode.createTextNode(sprintf(segmented)));  
    docRootNode.appendChild(Node2);  
    
    detect_size = size(minp);
    for i = 1:detect_size(1)
        xmin = minp(i,2); ymin = minp(i,1); xmax = maxp(i,2); ymax = maxp(i,1);
        xmin = num2str(xmin); ymin = num2str(ymin); xmax = num2str(xmax); ymax = num2str(ymax);
        thisElement = docNode.createElement('object');   
        docRootNode.appendChild(thisElement);  

            dataNode = docNode.createElement('name');  
            dataNode.appendChild(docNode.createTextNode(sprintf(name)));  
            thisElement.appendChild(dataNode);  

            dataNode = docNode.createElement('pose');  
            dataNode.appendChild(docNode.createTextNode(sprintf(pose)));  
            thisElement.appendChild(dataNode);  

            dataNode = docNode.createElement('truncated');  
            dataNode.appendChild(docNode.createTextNode(sprintf(truncated)));  
            thisElement.appendChild(dataNode);  

            dataNode = docNode.createElement('difficult');  
            dataNode.appendChild(docNode.createTextNode(sprintf(difficult)));  
            thisElement.appendChild(dataNode); 

            thisElement2 = docNode.createElement('bndbox');   
            thisElement.appendChild(thisElement2);  

                dataNode = docNode.createElement('xmin');
                dataNode.appendChild(docNode.createTextNode(sprintf(xmin)));
                thisElement2.appendChild(dataNode);

                dataNode = docNode.createElement('ymin');
                dataNode.appendChild(docNode.createTextNode(sprintf(ymin)));
                thisElement2.appendChild(dataNode);         

                dataNode = docNode.createElement('xmax');
                dataNode.appendChild(docNode.createTextNode(sprintf(xmax)));
                thisElement2.appendChild(dataNode);    

                dataNode = docNode.createElement('ymax');
                dataNode.appendChild(docNode.createTextNode(sprintf(ymax)));
                thisElement2.appendChild(dataNode);  
    end
xmlwrite([path xmlFileName],docNode);  