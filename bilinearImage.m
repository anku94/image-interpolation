function [imActual] = bilinearImage(img,zoom)
	img = imread(img);
	imZoom = bilinearInterpolation(img,1/zoom);
	imActual = bilinearInterpolation(imZoom,zoom);
end
