# WhatFlower
iOS application by which you can capture a photo of a flower by your camera, detect its type using Machine Learning tools, and show its information from Wikipedia. Implemented using CoreML and Wikipedia API.

 # IMPORTANT:
 
Inorder for this application to run on your device you have to do the following: (Sorry, I had to remove them due to large size)
 
- You have to install the pods written in podfile.
- Also install Caffe model from here: https://s3.amazonaws.com/jgoode/oxford102.caffemodel (+200MB).
- Then convert the caffe model into .mlmodel using this python script: (in the same directory of your downloaded Caffe model file)
  Remember that you have to run python 2.7 environment 

import coremltools

caffe_model = ('oxford102.caffemodel', 'deploy.prototxt')

labels = 'flower-labels.txt'

coreml_model = coremltools.converters.caffe.convert(
		caffe_model,
		class_labels = labels,
		image_input_names = 'data'
	)
coreml_model.save('FlowerClassifier.mlmodel')

- You will find .mlmodel file in the same folder, Copy and paste it in your Xcode project folder and You're done 😎

oh yeah and I forgot, you need physical device to run this app because it uses phone camera which is not supported in simulator. 
Or you can just edit your code in ViewDiDLoad() method in ViewController.swift :
from:
	imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.cameraCaptureMode = .photo
to: 
	imagePicker.sourceType = .photoLibrary
So you can use Photo Library on simulator instead of using camera.
