function [imActual] = bicubicImage(img,zoom)
	img = imread(img);
	imZoom = bicubicInterpolation(img,1/zoom);
	imActual = bicubicInterpolation(imZoom,zoom);
end
