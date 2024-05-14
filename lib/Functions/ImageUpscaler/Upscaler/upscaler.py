import cv2
from cv2 import dnn_superres


def upscale(img, alg_name, scale, path):
    # Create an SR object
    sr = cv2.dnn_superres.DnnSuperResImpl_create()
    # Read the desired model
    sr.readModel(path)
    # Set the desired model and scale to get correct pre- and post-processing
    sr.setModel(alg_name, scale)
    # Upscale the image
    result = sr.upsample(img)
    return result

def upscaleMain(inputFp, outputFp, p):
    img = cv2.imread(inputFp)
    res = upscale(img=img, alg_name='espcn', scale=4, path=p)
    res2 = cv2.blur(res, (15, 15))
    cv2.imwrite(outputFp, res2)
    return outputFp