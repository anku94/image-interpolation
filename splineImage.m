function [imActual] = splineImage(img,zoom)
	img = imread(img);
	imZoom = splineInterpolation(img,1/zoom);
	imActual = splineInterpolation(imZoom,zoom);
end
