# Synthetic Texture Segmentation Dataset

### Methodology to Generate a Segmentation Mask:
 1. Generate an initial region using 2-dimensional normal distribution or uniform distribution with equal probability. The mean and variance are generated randomly.
 2. Use a random threshold to binarize the obtained region.
 3. Generate another shape using 2-dimensional normal distribution or uniform distribution with equal probability. The mean is a random point in initial region and variance is generated randomly.
 4. Use a random threshold to binarize the new shape.
 5. Add the new shape to initial region and binarize the result.
 6. Repeat steps 3, 4 & 5 10 times. Final result obtained will be 1 region.
 7. Repeat above steps 3-5 times with equal probability to get 3-5 regions.
 8. Distinctly label each region and add them together. Randomly assign the overlapping parts to one of the regions.
 9. Smoothen the edges of regions in the segmentation mask by changing the label of each pixel to the mode in the 10x10 window surrounding it. This is the final segmentation mask.



### Dataset Specifications:
 1. 10,000 Masks
 2. 5 images from each mask with random textures for each region. Total 50,000 images
 3. Training Set: 42000 images
 4. Validation Set: 3000 images
 5. Test Set: 5000 images
 
 
 ### Inspiration:
 ```
 @INPROCEEDINGS{7299014,
  author={N. {Khan} and M. {Algarni} and A. {Yezzi} and G. {Sundaramoorthi}},
  booktitle={2015 IEEE Conference on Computer Vision and Pattern Recognition (CVPR)}, 
  title={Shape-tailored local descriptors and their application to segmentation and tracking}, 
  year={2015},
  volume={},
  number={},
  pages={3890-3899},
  doi={10.1109/CVPR.2015.7299014}}
  ```
