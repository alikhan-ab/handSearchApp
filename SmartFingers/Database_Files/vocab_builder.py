import caffe
import numpy as np
import os.path






caffe.set_mode_gpu()
caffe.set_device(0)

input_dir = '/media/nurobot427/Extra/SeniorProject/new_hands'
top1_file = '/media/nurobot427/Extra/SeniorProject/files/database_1'
top3_file = '/media/nurobot427/Extra/SeniorProject/files/database_3'
top5_file = '/media/nurobot427/Extra/SeniorProject/files/database_5'


model_path = '/media/nurobot427/Extra/SeniorProject/1miohands-modelzoo-v2/deploy.prototxt'
weights_path = '/media/nurobot427/Extra/SeniorProject/1miohands-modelzoo-v2/1miohands-v2.caffemodel'

net = caffe.Net(model_path, weights_path, caffe.TEST)

mu = np.load("/media/nurobot427/Extra/SeniorProject/1miohands-modelzoo-v2/227x227-TRAIN-allImages-forFeatures-0label-227x227handpatch.mean.npy")
mu = mu.mean(1).mean(1)	

transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})
transformer.set_transpose('data', (2,0,1))  # move image channels to outermost dimension
transformer.set_mean('data', mu)            # subtract the dataset-mean value in each channel
transformer.set_raw_scale('data', 255)      # rescale from [0, 1] to [0, 255]
transformer.set_channel_swap('data', (2,1,0))  # swap channels from RGB to BGR


f1 = open(top1_file, "a+")
f3 = open(top3_file, "a+")
f5 = open(top5_file, "a+")

i = 0

for entity in os.scandir(input_dir):
	if not os.path.isdir(entity):
		continue



	sign = os.path.basename(entity.path) # sign from folder name

	

	top1 = set()
	top3 = set()
	top5 = set()

	for hand in os.scandir(entity.path):
		if hand.path.endswith("jpg"):
			net.blobs['data'].data[...] = transformer.preprocess('data',caffe.io.load_image(hand.path))
			pred = net.forward()

			a = np.argsort(-pred['prob'][0])

			top1.add(np.argmax(pred['prob']))
			top3.update(a[:3])
			top5.update(a[:5])

	line_1 = sign + "," + ",".join(str(i) for i in top1) + "\n"
	line_3 = sign + "," + ",".join(str(i) for i in top3) + "\n"
	line_5 = sign + "," + ",".join(str(i) for i in top5) + "\n"

	f1.write(line_1)
	f3.write(line_3)
	f5.write(line_5)


	i+=1
	print(str(i) + ": " + sign)

	



f1.close()
f3.close()
f5.close()