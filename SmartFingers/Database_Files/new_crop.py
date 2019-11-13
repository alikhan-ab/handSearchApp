from random import sample
from os import listdir
from os.path import isfile, join
from PIL import Image
import re


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
	x_padding = 20
	y_padding = 30

	w_o = 92
	h_o = 132

	ratio = w_o/h_o

	x1 = a[1] - x_padding
	y1 = a[0] - y_padding

	x2 = a[3] + x_padding
	y2 = a[2] + y_padding

	w = x2 - x1
	h = y2 - y1

	if w/h > ratio:
		# increase y
		y_add = (w / ratio - h) / 2

		y1 -= y_add
		y2 += y_add



	elif w/h < ratio:
		x_add = (ratio * h - w) / 2

		x1 -= x_add
		x2 += x_add





	return [x1, y1, x2, y2]
	

list_path = '/media/nurobot427/Extra/SeniorProject/reversed.txt'
frame_folder_path = '/media/nurobot427/Extra/SeniorProject/Frames'

to_crop = []
with open(list_path) as fp:
	line = fp.readline()
	while line:
		crop = get_crop(line.strip())
		to_crop.append(crop)
		line = fp.readline()

i = 1
for c in to_crop:
	frame_path = join(frame_folder_path, c[0], c[1])
	coords = make_coords_array(c[2])
	save_location = '/media/nurobot427/Extra/SeniorProject/new_hands/result_' + c[1][:-4] + "_" + c[2] + ".jpg"
	print(i)
	print(save_location)
	crop_frame(frame_path, coords, save_location)
	i+=1