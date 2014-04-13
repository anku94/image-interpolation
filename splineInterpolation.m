function [imZoom] = splineInterpolation(img,zoom)

	[r c d] = size(img);
	img = cast(img,'double');	
	factor = 1/zoom;
	x = 1:c;
	xx = 1:factor:(c+1-factor);
	for i = 1:r
    		cs(i,:,1) = [spline(x,[0 img(i,:,1) 0],xx),img(i,end,1)];
    		if d > 1
        		cs(i,:,2) = [spline(x,[0 img(i,:,2) 0],xx),img(i,end,2)];
        		cs(i,:,3) = [spline(x,[0 img(i,:,3) 0],xx),img(i,end,3)];
    		end
	end
	y = 1:r;
	yy = 1:factor:(r+1-factor);
	for i = 1:(zoom*c)
    		us(:,i,1) = (spline(y,[0 cs(:,i,1)' 0],yy))';
    		if d > 1
        		us(:,i,2) = (spline(y,[0 cs(:,i,2)' 0],yy))';
        		us(:,i,3) = (spline(y,[0 cs(:,i,3)' 0],yy))';
    		end
	end
	imZoom = cast(us,'uint8');
end

