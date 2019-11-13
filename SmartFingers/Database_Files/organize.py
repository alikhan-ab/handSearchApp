from os import listdir
from os.path import isfile, join
import re
from PIL import Image
# outputs_path = '/media/nurobot427/Extra/SeniorProject/Hand-CNN-master/outputs'
# onlyfiles = [f for f in listdir(outputs_path) if isfile(join(mypath, f))]
# print(len(onlyfiles))
# print(onlyfiles[0])

# s = set()
# reapeated = 0
# for f in onlyfiles:
# 	name = f

# 	if name is in s:
# 		reapeated+=1
# 	else:
# 		name.add(f)


def get_crop(line):
	if line:
		p = re.compile("(.+)(frame\d+.jpg),(.*)")
		result = p.search(line)
		sign_name = result.group(1)
		frame_name = result.group(1) + result.group(2)
		coords = result.group(3)
		return (sign_name, frame_name, coords)


def crop_frame(image_path, coords, save_location):
	image_obj = Image.open(image_path)
	cropped_image = image_obj.crop(coords)
	cropped_image.save(save_location)

def make_coords_array(string):
	a = list(map(int, string.split(",")))
	padding = 30

	return [a[1] - padding, a[0] - padding, a[3] + padding, a[2] + padding]

def get_foder_name(frame_name):
	p = re.compile(".+)frame\d+.jpg")
	

list_path = '/media/nurobot427/Extra/SeniorProject/reversed.txt'
frame_folder_path = '/media/nurobot427/Extra/SeniorProject/Frames'

s = set()
to_crop = []
with open(list_path) as fp:
	line = fp.readline()
	while line:
		crop = get_crop(line.strip())
		if crop[1] in s:
			to_crop.append(crop)
		else:
			s.add(crop[1])
		line = fp.readline()


for c in to_crop:
	frame_path = join(frame_folder_path, c[0], c[1])
	coords = make_coords_array(c[2])
	save_location = '/media/nurobot427/Extra/SeniorProject/Hand-CNN-master/outputs/result_' + c[1][:-4] + "_" + c[2] + ".jpg"
	print(save_location)
	crop_frame(frame_path, coords, save_location)

