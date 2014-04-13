from matplotlib import image, pyplot
from numpy import multiply, real, append, zeros, array, dot
from numpy.fft import fft2, fftshift, ifft2, ifftshift
from scipy.misc import imresize
import sys, Image

swap = lambda (x, y): (y, x)

def zeropad2(x, shape):
    m, n = x.shape
    p, q = shape
    assert p > m
    assert q > n
    tb = zeros(((p - m) / 2, n))
    lr = zeros((p, (q - n) / 2))
    x = append(tb, x, axis = 0)
    x = append(x, tb, axis = 0)
    x = append(lr, x, axis = 1)
    x = append(x, lr, axis = 1)
    return x

def reshape((x, y), factor):
    return (int(factor * x), int(factor * y))

def imname(n, f, meth = None):

    ex = n.split('.')[-1]
    nm = '.'.join(n.split('.')[:-1])

    if meth != None:
        s = "%s-%s-%0.2fx.%s"%(meth, nm, f, ex)
    else:
        s = "%s-%0.2fx.%s"%(nm, f, ex)
    return s

def makeGray(fname):
    img = Image.open(fname).convert('L')
    img.save(fname)
    return fname

def interpolate(impath, factor, source):
    print impath, source
    img = image.imread(source)
    fft = fftshift(fft2(img))

    fft = zeropad2(fft, reshape(fft.shape, factor))

    ifft = ifft2(ifftshift(fft))
    ifft = real(ifft)

    fig2 = pyplot.figure(figsize = swap(ifft.shape), dpi = 1)
    fig2.figimage(ifft, cmap = pyplot.cm.gray)
    pyplot.savefig(imname(impath, factor, "fft"), dpi = 1)
    makeGray(imname(impath, factor, "fft"))

def makeSmall(impath, factor):
    img = image.imread(impath)

    x = img.shape
    y = (int(x[0]*factor), int(x[1]*factor))
    img = imresize(img, y)

    fig2 = pyplot.figure(figsize = img.shape, dpi = 1)
    fig2.figimage(img, cmap = pyplot.cm.gray)
    pyplot.savefig(imname(impath, factor), dpi = 1)

    fname = imname(impath, factor)
    makeGray(fname)
    return fname

if __name__ == "__main__":
    l = len(sys.argv)
    if l != 3:
        sys.exit(-1)
    name = sys.argv[1]
    factor = float(sys.argv[2])

    source = makeSmall(name, 1.0/factor)
    print source

    print "\n\tEnlarging %s by %0.1f ...\n"%(name, factor)
    interpolate(name, factor, source)
