import caffe
import numpy as np
import os.path

caffe.set_mode_gpu()
caffe.set_device(0)

folder_path = '/media/nurobot427/Extra/SeniorProject/test_hands'
folder_path2 = '/media/nurobot427/Extra/SeniorProject/28November_2011_Monday_tagesschau_default-12/1'
folder_path3 = '/media/nurobot427/Extra/SeniorProject/new_hands_test'

model = "deploy.prototxt"
if os.path.exists(model):
	print("Exists")	
else:
	print("Does not exist")

model_path = '/media/nurobot427/Extra/SeniorProject/1miohands-modelzoo-v2/deploy.prototxt'
weights_path = '/media/nurobot427/Extra/SeniorProject/1miohands-modelzoo-v2/1miohands-v2.caffemodel'

file = []
file+=["../28November_2011_Monday_tagesschau_default-12/1/*.png_fn000178-0.png"]

net = caffe.Net(model_path, weights_path, caffe.TEST)

mu = np.load("/media/nurobot427/Extra/SeniorProject/1miohands-modelzoo-v2/227x227-TRAIN-allImages-forFeatures-0label-227x227handpatch.mean.npy")
mu = mu.mean(1).mean(1)	

transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})
transformer.set_transpose('data', (2,0,1))  # move image channels to outermost dimension
transformer.set_mean('data', mu)            # subtract the dataset-mean value in each channel
transformer.set_raw_scale('data', 255)      # rescale from [0, 1] to [0, 255]
transformer.set_channel_swap('data', (2,1,0))  # swap channels from RGB to BGR


print(net.blobs['data'].data.shape)




for entry in os.scandir(folder_path3):
		if entry.path.endswith("jpg"):
			net.blobs['data'].data[...] = transformer.preprocess('data',caffe.io.load_image(entry.path))
			pred = net.forward()
			print("==============")
			print(entry.path)
			print(np.argmax(pred['prob']))


