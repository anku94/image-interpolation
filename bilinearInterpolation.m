function [imZoom] = bilinearInterpolation(img, zoom)
	[r c d] = size(img);
	rn = floor(zoom*r);
	cn = floor(zoom*c);
	s = zoom;
	imZoom = zeros(rn,cn,d);
	for i = 1:rn;
    		x1 = cast(floor(i/s),'uint32');
    		x2 = cast(ceil(i/s),'uint32');
    		if x1 == 0
        		x1 = 1;
    		end
    		x = rem(i/s,1);
    		for j = 1:cn;
        		y1 = cast(floor(j/s),'uint32');
        		y2 = cast(ceil(j/s),'uint32');
        		if y1 == 0
            			y1 = 1;
        		end
        		ctl = img(x1,y1,:);
        		cbl = img(x2,y1,:);
        		ctr = img(x1,y2,:);
        		cbr = img(x2,y2,:);
        		y = rem(j/s,1);
        		tr = (ctr*y)+(ctl*(1-y));
        		br = (cbr*y)+(cbl*(1-y));
        		imZoom(i,j,:) = (br*x)+(tr*(1-x));
    		end
	end
	imZoom = cast(imZoom,'uint8');
end
